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
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                marketAndCode
                VStack(alignment: .leading, spacing: 8) {
                    title
                    fluctuationRate
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 6)
        .frame(width: 160, height: 100)
        .background(Color.white)
        .cornerRadius(8)
    }
}

extension HomeStockView {
    var marketAndCode: some View {
        HStack(spacing: 2) {
            if let market = stock.market?.rawValue {
                Text(market)
                Text("|")
            }
            Text(stock.code ?? "")
        }.font(.system(size: 10, weight: .medium))
        .foregroundStyle(Color.gray)
        .padding(.top, 2)
    }
    
    var title: some View {
        Text(stock.title ?? "")
            .lineLimit(2)
            .minimumScaleFactor(0.5)
            .font(.system(size: 20, weight: .bold))
    }
    
    var fluctuationRate: some View {
        Group {
            let fluctuationRate = stock.formatFluctuationRateString()
            switch change {
            case .up:
                Text("+" + fluctuationRate + "%")
                    .foregroundStyle(.red)
            case .down:
                Text(fluctuationRate + "%")
                    .foregroundStyle(.blue)
            default: EmptyView()
            }
        }
        .font(.system(size: 16, weight: .bold))
    }
}

#Preview {
    VStack {
        HomeStockView(stock: Stock(title: "주식2", code: "000044", market: .kosdaq, themas: nil), change: .up)
        HomeStockView(stock: Stock(title: "주식313", code: "000334", market: .kospi, themas: nil), change: .down)
    }
}
