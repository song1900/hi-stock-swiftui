//
//  HiStockApp.swift
//  HiStock
//
//  Created by 송우진 on 3/27/24.
//

import SwiftUI

@main
struct HiStockApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
