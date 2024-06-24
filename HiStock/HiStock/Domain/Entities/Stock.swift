//
//  Stock.swift
//  HiStock
//
//  Created by 송우진 on 6/14/24.
//

import Foundation

struct Stock: Codable, Equatable, Identifiable {
    var id: Int { code?.hashValue ?? 0 }
    var title: String?
    var code: String?
    var price: Int?
    var market: MarketType?
    var fluctuationRate: Double?
    var themas: [String]?
    
    enum CodingKeys: CodingKey {
        case title, code, price, market, fluctuationRate, themas
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        code = try? container.decodeIfPresent(String.self, forKey: .code)
        market = try? container.decodeIfPresent(MarketType.self, forKey: .market)
        themas = try? container.decodeIfPresent([String].self, forKey: .themas)
        price = try? container.decodeIfPresent(Int.self, forKey: .price)
        fluctuationRate = try? container.decodeIfPresent(Double.self, forKey: .fluctuationRate)
    }
    
    init(
        title: String?,
        code: String?,
        price: Int?,
        market: MarketType?,
        fluctuationRate: Double?,
        themas: [String]?
    ) {
        self.title = title
        self.code = code
        self.price = price
        self.market = market
        self.fluctuationRate = fluctuationRate
        self.themas = themas
    }
}

extension Stock {
    func formatFluctuationRateString() -> String {
        String(format: "%.2f", fluctuationRate ?? 0)
    }
}
