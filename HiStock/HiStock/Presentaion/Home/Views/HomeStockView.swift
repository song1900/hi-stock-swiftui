//
//  HomeStockView.swift
//  HiStock
//
//  Created by 송우진 on 6/14/24.
//

import SwiftUI

struct HomeStockView: View {
    @State var stock: Stock
    var change: StockChange
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                title
                fluctuationRate
            }.padding(.leading, 16)
            Spacer()
        }.frame(width: 160, height: 100)
        .background { Color.gray }
        .cornerRadius(8)
    }
    
    var title: some View {
        Text(stock.title)
            .fontWeight(.bold)
    }
    
    var fluctuationRate: some View {
        Group {
            let fluctuationRate = String(stock.fluctuationRate ?? 0)
            switch change {
            case .up:
                Text("+" + fluctuationRate + "%")
                    .foregroundStyle(.red)
            case .down:
                Text("-" + fluctuationRate + "%")
                    .foregroundStyle(.blue)
            default: EmptyView()
            }
        }
        .fontWeight(.bold)
        
    }
}

#Preview {
    VStack {
        HomeStockView(stock: Stock(title: "주식타이틀", price: 1999, code: "202020", market: .kospi, fluctuationRate: 20, thema: ["테마1"]), change: .up)
        HomeStockView(stock: Stock(title: "주식타이틀", price: 1999, code: "202020", market: .kospi, fluctuationRate: 20, thema: ["테마1"]), change: .down)
    }
}
