//
//  SearchResultListCell.swift
//  HiStock
//
//  Created by 송우진 on 6/24/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchResultListCell: View {
    @State var store: StoreOf<SearchReducer>
    @Binding var stock: Stock
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            HStack(spacing: 13) {
                titleView
                Spacer()
                priceView
            }
            .padding(.horizontal, 12)
            
            if let themas = stock.themas?.filter({ $0 != store.searchText }),
               !themas.isEmpty
            {
                themaScrollView(themas: themas)
            }
        }).listRowInsets(EdgeInsets())
        .padding(.vertical, 10)
    }
    
    var titleView: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(stock.code ?? "")
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(Color.gray)
            Text(stock.title ?? "")
                .fontWeight(.bold)
        }
    }
    
    var priceView: some View {
        Group {
            let updown = stock.price?.upDown ?? .unchanged
            Group {
                Text("\(stock.price?.close ?? 0)")
                Text("\(updown == .up ? "+" : "")\(stock.formatFluctuationRateString())%")
                    .frame(width: 75, alignment: .trailing)
            }.fontWeight(.semibold)
            .foregroundStyle(updown.color)
        }
    }
    
    func themaScrollView(themas: [String]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .center,
                       spacing: 8,
                       pinnedViews: .sectionHeaders) {
                ForEach(themas, id: \.self) {
                    Text($0)
                        .font(.system(size: 10, weight: .medium))
                        .randomBackgroundColor()
                }
            }.padding(.horizontal, 12)
        }
    }
}

struct SearchResultListCell_Previews: PreviewProvider {
    static var previews: some View {
        @State var previewStock = Stock(title: "테스트", code: "000001", market: .kospi, themas: ["테마1", "테마2"])
        SearchResultListCell(store: HiStockApp.searchStore,
                             stock: .constant(previewStock))
        .frame(height: 80)
    }
}
