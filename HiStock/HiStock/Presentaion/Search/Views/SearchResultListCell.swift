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
            Group {
                Text("\(stock.price?.close ?? 0)")
                Text("\(stock.formatFluctuationRateString())%")
            }.foregroundStyle(stock.price?.upDown?.color ?? StockChange.unchanged.color)
        }
        .padding(.horizontal, 0)
    }
}

struct SearchResultListCell_Previews: PreviewProvider {
    static var previews: some View {
        @State var previewStock = Stock(title: "테스트", code: nil, market: nil, themas: nil)
        SearchResultListCell(stock: .constant(previewStock))
    }
}
