//
//  SearchResultListCell.swift
//  HiStock
//
//  Created by 송우진 on 6/24/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchResultListCell: View {
    @Binding var stock: Stock
    
    var body: some View {
        HStack(spacing: 12) {
            Text(stock.title ?? "")
                .fontWeight(.bold)
            Spacer()
            Text("\(stock.price ?? 0)")
                .foregroundStyle(StockChange.up.color)
            Text("+\(stock.formatFluctuationRateString())%")
                .foregroundStyle(StockChange.up.color)
        }
        .padding(.horizontal, 0)
    }
}

struct SearchResultListCell_Previews: PreviewProvider {
    static var previews: some View {
        @State var previewStock = Stock(title: "테스트", code: nil, price: 9999999, market: nil, fluctuationRate: 10, themas: nil)
        SearchResultListCell(stock: .constant(previewStock))
    }
}
