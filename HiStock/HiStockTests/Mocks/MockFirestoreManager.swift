//
//  MockFirestoreManager.swift
//  HiStock
//
//  Created by 송우진 on 6/23/24.
//

import FirebaseFirestore
@testable import HiStock

final class MockFirestoreManager: FirestoreManaging {
    
    func fetchStocks(thema: String) async throws -> [Stock] {
        return [Stock(title: "테스트 주식", code: nil, market: nil, themas: [thema])]
    }
    
    func fetchMakets() async throws -> [Market] {
        return [
            Market(type: .kospi),
            Market(type: .kosdaq)
        ]
    }
}
