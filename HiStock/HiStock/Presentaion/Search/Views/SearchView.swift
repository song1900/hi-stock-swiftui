//
//  SearchView.swift
//  HiStock
//
//  Created by 송우진 on 6/18/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    @State var store: StoreOf<SearchReducer>
    
    init(store: StoreOf<SearchReducer>) {
        self.store = store
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SearchView(store: HiStockApp.searchStore)
}
