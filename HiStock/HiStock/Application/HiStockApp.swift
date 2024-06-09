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
    
    static let store = Store(initialState: HomeReducer.State()) {
        HomeReducer()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(store: HiStockApp.store)
        }
    }
}
