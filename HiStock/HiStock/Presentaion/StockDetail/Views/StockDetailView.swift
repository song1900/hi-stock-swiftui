//
//  StockDetailView.swift
//  HiStock
//
//  Created by 송우진 on 7/5/24.
//

import SwiftUI
import ComposableArchitecture

struct StockDetailView: View {
    @State var store: StoreOf<StockDetailFeature>
    
    var body: some View {
        Text(store.stock.title ?? "데이터 없음")
    }
}

#Preview {
    StockDetailView(store: .init(initialState: StockDetailFeature.State(stock: Stock(title: "테스트 종목", code: nil, market: nil, themas: nil)),
                                 reducer: {
        StockDetailFeature()
    }))
}
