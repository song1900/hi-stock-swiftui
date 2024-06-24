//
//  MockFirestoreManager.swift
//  HiStock
//
//  Created by 송우진 on 6/23/24.
//

import FirebaseFirestore

final class MockFirestoreManager: FirestoreManaging {
    
    func fetchStocks(thema: String) async throws -> [Stock] {
        return [Stock(title: "테스트 주식", code: nil, price: nil, market: nil, fluctuationRate: nil, themas: [thema])]
    }
}
