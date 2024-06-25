//
//  Market.swift
//  HiStock
//
//  Created by 송우진 on 6/25/24.
//

import Foundation

struct Market: Codable, Equatable {
    var type: MarketType?
    var price: Double?
    var date: String?
    
    enum CodingKeys: CodingKey {
        case type, price, date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try? container.decodeIfPresent(MarketType.self, forKey: .type)
        price = try? container.decodeIfPresent(Double.self, forKey: .price)
        date = try? container.decodeIfPresent(String.self, forKey: .date)
    }
    
    init(type: MarketType?) {
        self.type = type
    }
}
