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
            Stock(title: "주식1", code: "000002", price: 12313, market: .kosdaq, fluctuationRate: 18.00, themas: nil),
            Stock(title: "주식2", code: "000014", price: 11241233, market: .kosdaq, fluctuationRate: 8.00, themas: nil)
        ]
        var downStocks: [Stock] = [
            Stock(title: "주식2", code: "000034", price: 812433, market: .kosdaq, fluctuationRate: 28.00, themas: nil),
            Stock(title: "주식2", code: "000044", price: 11241233, market: .kosdaq, fluctuationRate: 8.00, themas: nil)
        ]
    }
}
