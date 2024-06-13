//
//  HomeView.swift
//  HiStock
//
//  Created by 송우진 on 6/9/24.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    @State var store: StoreOf<HomeReducer>
    
    init(store: StoreOf<HomeReducer>) {
        self.store = store
    }
    
    var body: some View {
        ScrollView(.vertical) {
            HStack(alignment: .center, spacing: 11, content: {
                MarketInformationView(store: store, marketType: .kospi)
                MarketInformationView(store: store, marketType: .kosdaq)
            })
            .padding(.horizontal, 16)
        }   
    }
}

#Preview {
    HomeView(store: HiStockApp.store)
}
