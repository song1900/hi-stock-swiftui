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
        Text(stock.title ?? "")
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
        HomeStockView(stock: Stock(title: "주식2", code: "000044", price: 11241233, market: .kosdaq, fluctuationRate: 8.00, themas: nil), change: .up)
        HomeStockView(stock: Stock(title: "주식313", code: "000334", price: 1333, market: .kospi, fluctuationRate: 8.00, themas: nil), change: .down)
    }
}
