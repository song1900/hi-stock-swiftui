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
            $0.stocks = [Stock(title: "테스트 주식", code: nil, market: nil, themas: ["테스트"])]
        }
    }
    
    func test검색실패시_경고창노출() async {
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer()
        }
        
        await store.send(\.view.binding.searchText, "실패") {
            $0.searchText = "실패"
        }
        
        await store.send(.performSearch) {
            $0.searchPerformed = true
            $0.isLoading = true
        }
        
        await store.receive(\.searchResponse.failure) {
            $0.isLoading = false
            $0.alert = AlertState {
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
        } 
    }
    
    func test테마클릭시_검색어변경후_데이터반환() async {
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer()
        }
        
        await store.send(.themaButtonTapped(thema: "테스트")) {
            $0.searchText = "테스트"
        }
        
        await store.receive(\.performSearch) {
            $0.searchPerformed = true
            $0.isLoading = true
        }
        
        await store.receive(\.searchResponse.success) {
            $0.isLoading = false
            $0.stocks = [Stock(title: "테스트 주식", code: nil, market: nil, themas: ["테스트"])]
        }
    }

}
