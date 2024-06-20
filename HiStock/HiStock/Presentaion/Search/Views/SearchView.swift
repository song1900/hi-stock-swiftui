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
        VStack(spacing: 0, content: {
            searchTextField
            Divider()
            Spacer()
        })
    }
}

extension SearchView {
    var searchTextField: some View {
        HStack(alignment: .center, spacing: 4, content: {
            Image(systemName: "magnifyingglass")
            TextField("검색어를 입력해 주세요", text: $store.searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .onSubmit {
                    print(store.searchText)
                }
        })
        .frame(height: 40)
        .padding(.horizontal, 11)
    }
}

#Preview {
    SearchView(store: HiStockApp.searchStore)
}
