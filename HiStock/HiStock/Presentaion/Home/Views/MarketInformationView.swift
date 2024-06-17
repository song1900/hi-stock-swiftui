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
    @State var marketType: MarketType
    
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
    
    var contents: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("3,000.00")
                Text("6.25 +0.30%")
                    .foregroundStyle(.red)
                Spacer()
            }
            .padding([.leading, .top], 10)
            Spacer()
        }
        .background {
            Color.white
        }
    }
}

#Preview {
    MarketInformationView(
        store: HiStockApp.store,
        marketType: .kospi
    )
}
