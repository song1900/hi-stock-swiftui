//
//  HomeReducer.swift
//  HiStock
//
//  Created by 송우진 on 6/9/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct HomeReducer {
    @Dependency(\.firestoreClient) var firestoreClient
    
    @ObservableState
    struct State: Equatable {
        var markets: [Market] = []
        var upStocks: [Stock] = []
        var downStocks: [Stock] = []
    }
    
    enum Action {
        case fetchMarkets
        case fetchMarketsResponse(TaskResult<[Market]>)
        case fetchStocks(updown: StockChange)
        case fetchStocksResponse(TaskResult<([Stock], StockChange)>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchMarkets:
                return .run { send in
                    await send(
                        .fetchMarketsResponse(
                            TaskResult { try await
                                firestoreClient.fetchMarkets()
                            }
                        )
                    )
                }
                
            case let .fetchMarketsResponse(.success(response)):
                state.markets = response
                return .none
                
            case let .fetchMarketsResponse(.failure(error)):
                Log.error("performGetMarket Error", error)
                return .none
            case .fetchStocks(updown: let updown):
                return .run { send in
                    await send(.fetchStocksResponse(
                        TaskResult { try await
                            firestoreClient.fetchUpDownStocks(change: updown, limit: 10)
                        }
                    ))
                }
            case let .fetchStocksResponse(.success(response)):
                switch response.1 {
                case .up: state.upStocks = response.0
                case .down: state.downStocks = response.0
                default: 
                    return .run { send in
                        await send(.fetchStocksResponse(.failure(NSError())))
                    }
                }
                return .none
                
            case let .fetchStocksResponse(.failure(error)):
                Log.error("Fetch Stocks Response Failure", error)
                return .none
            }
            
        }
    }
}
