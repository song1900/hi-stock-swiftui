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
    
    var body: some View {
        VStack(spacing: 0) {
            searchTextField
            resultListView
            Spacer()
        }
    }
}

extension SearchView {
    var searchTextField: some View {
        HStack(alignment: .center, spacing: 4) {
            Image(systemName: "magnifyingglass")
            TextField("검색어를 입력해 주세요", text: $store.searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .onSubmit {
                    store.send(.performSearch)
                }
        }.frame(height: 40)
        .padding(.horizontal, 11)
        .overlay(alignment: .bottom) {
            Divider()
        }
    }
    
    var resultListView: some View {
        List {
            ForEach($store.stocks) {
                SearchResultListCell(stock: $0)
            }
        }.listStyle(.plain)
    }
}

#Preview {
    SearchView(store: HiStockApp.searchStore)
}
