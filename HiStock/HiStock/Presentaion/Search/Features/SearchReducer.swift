//
//  SearchReducer.swift
//  HiStock
//
//  Created by 송우진 on 6/18/24.
//

import ComposableArchitecture

@Reducer
struct SearchReducer {
    @ObservableState
    struct State: Equatable {
        var searchText: String = ""
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.searchText): return .none
            case .binding(_): return .none
            }
        }
    }
}
