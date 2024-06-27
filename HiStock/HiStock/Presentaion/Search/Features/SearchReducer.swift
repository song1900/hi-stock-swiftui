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
        @Presents var alert: AlertState<Action.Alert>?
        var searchText: String = ""
        var stocks: [Stock] = []
        var isLoading = false
        var searchPerformed = false
    }
    
    enum Action: ViewAction {
        case performSearch
        case searchResponse(TaskResult<[Stock]>)
        case themaButtonTapped(thema: String)
        case alert(PresentationAction<Alert>)
        case view(View)
        
        @CasePathable
        enum View: BindableAction {
            case binding(BindingAction<State>)
        }
        
        @CasePathable
        enum Alert {
          case searchResponseError
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .view(.binding): return .none
            case let .themaButtonTapped(thema):
                state.searchText = thema
                return .run { send in
                    await send(.performSearch)
                }
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
                Log.error("SearchResponse Error", error)
                state.isLoading = false
                state.alert = AlertState {
                    TextState("검색에 실패했습니다")
                } actions: {
                    ButtonState(role: .destructive) {
                        TextState("닫기")
                    }
                    ButtonState(action: .searchResponseError) {
                        TextState("재시도")
                    }
                } message: {
                    TextState("재시도 버튼을 눌러주세요")
                }
                return .none
            case let .searchResponse(.success(response)):
                state.isLoading = false
                state.stocks = response
                return .none
            case .alert(.presented(.searchResponseError)):
                return .run { send in
                    await send(.performSearch)
                }
            case .alert:
                return .none
            }
        }
    }
}
