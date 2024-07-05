//
//  StockDetailFeature.swift
//  HiStock
//
//  Created by 송우진 on 7/5/24.
//

import ComposableArchitecture

@Reducer
struct StockDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        var stock: Stock
    }
    
    enum Action {
        
    }
}
