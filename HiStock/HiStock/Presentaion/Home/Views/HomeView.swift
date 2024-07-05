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
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ScrollView(.vertical) {
                LazyVStack(alignment: .center, spacing: 20, content: {
                    HStack(alignment: .center, spacing: 11) {
                        MarketInformationView(store: store, marketType: .kospi)
                        MarketInformationView(store: store, marketType: .kosdaq)
                    }
                    .padding(.horizontal, 16)
                    if !store.upStocks.isEmpty {
                        stocksScrollView(change: .up)
                    }
                    if !store.downStocks.isEmpty {
                        stocksScrollView(change: .down)
                    }
                })
            }
            .background(Color("app_background_color"))
            .onAppear(perform: {
                store.send(.fetchMarkets)
                store.send(.fetchStocks(updown: .up))
                store.send(.fetchStocks(updown: .down))
            })
        } destination: { store in
            switch store.state {
            case .detailItem:
                if let store = store.scope(state: \.detailItem, action: \.detailItem) {
                    StockDetailView(store: store)
                }
            }
        }
    }
    
    func stocksScrollView(change: StockChange) -> some View {
        VStack(alignment: .leading, spacing: 12, content: {
            stocksScrolltitle(change: change)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10, content: {
                    switch change {
                    case .up:
                        ForEach(store.upStocks) { stock in
                            HomeStockView(stock: stock, change: .up)
                                .onTapGesture {
                                    store.send(.stockTapped(stock))
                                }
                        }
                    case .down:
                        ForEach(store.downStocks) { stock in
                            HomeStockView(stock: stock, change: .down)
                                .onTapGesture {
                                    store.send(.stockTapped(stock))
                                }
                        }
                    default: EmptyView()
                    }
                }).padding(.horizontal, 16)
            }
        })
    }
    
    func stocksScrolltitle(change: StockChange) -> some View {
        Group {
            switch change {
            case .up: Text("상승 중이에요")
            case .down: Text("하락 중이에요")
            default: EmptyView()
            }
        }.font(.system(size: 18, weight: .bold))
        .padding(.horizontal, 16)
    }
    
}

#Preview {
    HomeView(store: HiStockApp.homeStore)
}
