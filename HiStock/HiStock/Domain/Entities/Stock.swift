//
//  Stock.swift
//  HiStock
//
//  Created by 송우진 on 6/14/24.
//

import Foundation

struct Stock: Equatable, Identifiable {
    var id: String { return code }
    var title: String
    var price: Int
    var code: String
    var market: MarketType
    var fluctuationRate: Double?
    var thema: [String]?
}
