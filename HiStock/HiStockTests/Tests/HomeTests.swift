//
//  HomeTests.swift
//  HiStockTests
//
//  Created by 송우진 on 6/25/24.
//

import ComposableArchitecture
import XCTest
@testable import HiStock

@MainActor
final class HomeTests: XCTestCase {
    
    func test마켓정보조회시_코스피코스닥반환() async {
        let store = TestStore(initialState: HomeReducer.State()) {
            HomeReducer()
        }
        
        await store.send(.fetchMarkets)
        await store.receive(\.fetchMarketsResponse.success) {
            $0.markets = [Market(type: .kospi), Market(type: .kosdaq)]
        }
    }
    
    func test_상승하락조회시_limit만큼주식목록반환_unchanged조회시_에러발생() async {
        let store = TestStore(initialState: HomeReducer.State()) {
            HomeReducer()
        }
        
        await store.send(.fetchStocks(updown: .up))
        await store.receive(\.fetchStocksResponse.success) {
            $0.upStocks = (0..<10).map({ Stock(title: "\($0)", code: "", market: .kospi, themas: nil) })
        }
        
        await store.send(.fetchStocks(updown: .down))
        await store.receive(\.fetchStocksResponse.success) {
            $0.downStocks = (0..<10).map({ Stock(title: "\($0)", code: "", market: .kosdaq, themas: nil) })
        }
        
        await store.send(.fetchStocks(updown: .unchanged))
        await store.receive(\.fetchStocksResponse.failure)
    }

}
