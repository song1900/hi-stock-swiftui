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
    }
    
    enum Action: ViewAction {
        case performSearch
        case searchResponse(Result<[Stock], Error>)
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
            case .performSearch:
                return .run { [searchText = state.searchText] send in
                    await send(
                        .searchResponse(
                            Result {
                                try await firestoreClient.fetchStocks(thema: searchText)
                            }
                        )
                    )
                }
            case let .searchResponse(.failure(error)):
                print("ERROR: \(error)")
                return .none
            case let .searchResponse(.success(response)):
                state.stocks = response
                response.forEach { print("✅ \($0)") }
                return .none
                
            }
        }
    }
}
