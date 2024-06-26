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
        HStack(spacing: 13) {
            VStack(alignment: .leading, spacing: 1) {
                Text(stock.code ?? "")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(Color.gray)
                Text(stock.title ?? "")
                    .fontWeight(.bold)
            }
            
            Spacer()
            let updown = stock.price?.upDown ?? .unchanged
            Group {    
                Text("\(stock.price?.close ?? 0)")
                Text("\(updown == .up ? "+" : "")\(stock.formatFluctuationRateString())%")
                    .frame(width: 75, alignment: .trailing)
            }.fontWeight(.semibold)
            .foregroundStyle(updown.color)
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
