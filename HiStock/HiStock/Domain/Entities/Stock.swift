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
    var price: StockPrice?
    var market: MarketType?
    var themas: [String]?
    
    enum CodingKeys: CodingKey {
        case title, code, price, market, themas
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        code = try? container.decodeIfPresent(String.self, forKey: .code)
        price = try? container.decodeIfPresent(StockPrice.self, forKey: .price)
        market = try? container.decodeIfPresent(MarketType.self, forKey: .market)
        themas = try? container.decodeIfPresent([String].self, forKey: .themas)
    }
    
    init(
        title: String?,
        code: String?,
        market: MarketType?,
        themas: [String]?
    ) {
        self.title = title
        self.code = code
        self.market = market
        self.themas = themas
    }
}

extension Stock {
    func formatFluctuationRateString() -> String {
        String(format: "%.2f", price?.percentChange ?? 0)
    }
}


struct StockPrice: Codable, Equatable {
    var open: Int?
    var close: Int?
    var high: Int?
    var low: Int?
    var percentChange: Double?
    var upDown: StockChange?
    
    enum CodingKeys: CodingKey {
        case open, close, high, low, percentChange, upDown
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        open = try? container.decodeIfPresent(Int.self, forKey: .open)
        close = try? container.decodeIfPresent(Int.self, forKey: .close)
        high = try? container.decodeIfPresent(Int.self, forKey: .high)
        low = try? container.decodeIfPresent(Int.self, forKey: .low)
        percentChange = try? container.decodeIfPresent(Double.self, forKey: .percentChange)
        upDown = try? container.decodeIfPresent(StockChange.self, forKey: .upDown)
    }
}
