//
//  MarketInformationView.swift
//  HiStock
//
//  Created by 송우진 on 6/10/24.
//

import SwiftUI
import ComposableArchitecture

struct MarketInformationView: View {
    @State var store: StoreOf<HomeReducer>
    var marketType: MarketType
    
    var body: some View {
        VStack(spacing: 0) {
            title
            contents
        }
        .frame(height: 140)
        .cornerRadius(8)
        .shadow(color: .gray, radius: 3)
    }
    
    var title: some View {
        ZStack {
            Color.gray
            Text(marketType.rawValue)
        }.frame(height: 44)
    }
    
    func priceText(market: Market?) -> some View {
        Group {
            let price = "\(market?.price ?? 0)"
            Text(price) 
        }
    }
    
    var contents: some View {
        Group {
            let market = store.markets.first(where: { $0.type == marketType })
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    priceText(market: market)
                    Text("6.25 +0.30%")
                        .foregroundStyle(.red)
                    Spacer()
                }
                .padding([.leading, .top], 10)
                Spacer()
            }
            .background { Color.white }
            .redacted(reason: market != nil ? [] : .placeholder)
        }
        
    }
                
}

#Preview {
    MarketInformationView(
        store: HiStockApp.homeStore,
        marketType: .kospi
    )
}
