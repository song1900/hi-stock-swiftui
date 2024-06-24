//
//  SearchReducer.swift
//  HiStock
//
//  Created by 송우진 on 6/18/24.
//

import ComposableArchitecture

@Reducer
struct SearchReducer {
    @Dependency(\.firestoreClient) var firestoreClient
    
    @ObservableState
    struct State: Equatable {
        var searchText: String = ""
        var stocks: [Stock] = []
        var isLoading = false
        var searchPerformed = false
    }
    
    enum Action: ViewAction {
        case performSearch
        case searchResponse(TaskResult<[Stock]>)
        case factResponse
        case view(View)
        
        @CasePathable
        enum View: BindableAction {
            case binding(BindingAction<State>)
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .view(.binding): return .none
            case .factResponse:
                state.isLoading = false
                return .none
            case .performSearch:
                state.searchPerformed = true
                state.isLoading = true
                return .run { [searchText = state.searchText] send in
                    await send(
                        .searchResponse(
                            TaskResult { try await
                                firestoreClient.fetchStocks(thema: searchText)
                            }
                        )
                    )
                }
            case let .searchResponse(.failure(error)):
                state.isLoading = false
                print("✨ ERROR: \(error)")
                return .none
                
            case let .searchResponse(.success(response)):
                state.isLoading = false
                state.stocks = response
                response.forEach { print("✅ \($0)") }
                return .none
                
            }
        }
    }
}
