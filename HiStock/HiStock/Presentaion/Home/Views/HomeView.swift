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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HomeView(store: HiStockApp.store)
}
