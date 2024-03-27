//
//  Item.swift
//  HiStock
//
//  Created by 송우진 on 3/27/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
