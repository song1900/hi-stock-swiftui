//
//  HiStockApp.swift
//  HiStock
//
//  Created by 송우진 on 3/27/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct HiStockApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    static let homeStore = Store(initialState: HomeReducer.State()) {
        HomeReducer()
            ._printChanges()
    }
    
    static let searchStore = Store(initialState: SearchReducer.State()) {
        SearchReducer()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView(store: HiStockApp.homeStore)
                    .tabItem {
                        Text("홈")
                    }
                SearchView(store: HiStockApp.searchStore)
                    .tabItem {
                        Text("검색")
                    }
            }
        }
    }
}
