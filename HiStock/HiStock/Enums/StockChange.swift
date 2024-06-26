//
//  StockChange.swift
//  HiStock
//
//  Created by 송우진 on 6/14/24.
//

import SwiftUI

enum StockChange: Int, Codable {
    case up = 1
    case down = 2
    case unchanged = 0
    
    var color: Color {
        switch self {
        case .up: return Color.red
        case .down: return Color.blue
        case .unchanged: return Color.black
        }
    }
}
