//
//  SearchTests.swift
//  HiStockTests
//
//  Created by 송우진 on 6/22/24.
//

import ComposableArchitecture
import XCTest
@testable import HiStock

@MainActor
final class SearchTests: XCTestCase {

    func test검색성공시_데이터반환() async {
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer()
        }
        
        await store.send(\.view.binding.searchText, "테스트") {
            $0.searchText = "테스트"
        }
        
        await store.send(.performSearch) {
            $0.searchPerformed = true
            $0.isLoading = true
        }

        await store.receive(\.searchResponse.success) {
            $0.isLoading = false
            $0.stocks = [Stock(title: "테스트 주식", code: nil, price: nil, market: nil, fluctuationRate: nil, themas: ["테스트"])]
        }

    }

}
