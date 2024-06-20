//
//  HomeReducer.swift
//  HiStock
//
//  Created by 송우진 on 6/9/24.
//

import ComposableArchitecture

@Reducer
struct HomeReducer {
    @ObservableState
    struct State: Equatable {
        var upStocks: [Stock] = [
            Stock(title: "주식1", price: 19999, code: "000001", market: .kospi, fluctuationRate: 18.00, thema: nil),
            Stock(title: "주식2", price: 199990, code: "000002", market: .kospi, fluctuationRate: 9.00 ,thema: nil)
        ]
        var downStocks: [Stock] = [
            Stock(title: "주식1", price: 2222222, code: "000003", market: .kosdaq, fluctuationRate: 10.09, thema: nil),
            Stock(title: "주식2", price: 13130, code: "000004", market: .kospi, fluctuationRate: 0.5, thema: nil)
        ]
    }
}
