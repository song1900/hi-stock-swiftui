//
//  HomeReducer.swift
//  HiStock
//
//  Created by 송우진 on 6/9/24.
//

import ComposableArchitecture

@Reducer
struct HomeReducer {
    @Dependency(\.firestoreClient) var firestoreClient
    
    @ObservableState
    struct State: Equatable {
        var markets: [Market] = []
        
        var upStocks: [Stock] = [
            Stock(title: "주식1", code: "000002", market: .kosdaq, themas: nil),
            Stock(title: "주식2", code: "000014", market: .kosdaq, themas: nil)
        ]
        var downStocks: [Stock] = [
            Stock(title: "주식2", code: "000034", market: .kosdaq, themas: nil),
            Stock(title: "주식2", code: "000044", market: .kosdaq, themas: nil)
        ]
    }
    
    enum Action {
        case performGetMarket
        case getMarketResponse(TaskResult<[Market]>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .performGetMarket:
                return .run { send in
                    await send(
                        .getMarketResponse(
                            TaskResult { try await
                                firestoreClient.fetchMarkets()
                            }
                        )
                    )
                }
                
            case let .getMarketResponse(.success(response)):
                state.markets = response
                return .none
                
            case let .getMarketResponse(.failure(error)):
                print("✨ ERROR: \(error)")
                return .none
            }
            
        }
    }
}
