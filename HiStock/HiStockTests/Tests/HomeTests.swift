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
        
        await store.send(.performGetMarket)
        await store.receive(\.getMarketResponse.success) {
            $0.markets = [Market(type: .kospi), Market(type: .kosdaq)]
        }
    }

}
