//
//  FirestoreClient.swift
//  HiStock
//
//  Created by 송우진 on 6/20/24.
//

import ComposableArchitecture

@DependencyClient
struct FirestoreClient {
    static let firestoreManager: FirestoreManaging = FirestoreManager()
    static let mockFirestoreManager: FirestoreManaging = MockFirestoreManager()

    var fetchStocks: (_ thema: String) async throws -> [Stock]
    var fetchMarkets: () async throws -> [Market]
}

extension FirestoreClient: DependencyKey {
    static let liveValue = Self (
        fetchStocks: { thema in
            return try await firestoreManager.fetchStocks(thema: thema)
        }, 
        fetchMarkets: {
            return try await firestoreManager.fetchMakets()
        }
    )
    static let testValue = Self (
        fetchStocks: { thema in
            return try await mockFirestoreManager.fetchStocks(thema: thema)
        }, 
        fetchMarkets: {
            return try await mockFirestoreManager.fetchMakets()
        }
    )
}

extension DependencyValues {
    var firestoreClient: FirestoreClient {
        get { self[FirestoreClient.self] }
        set { self[FirestoreClient.self] = newValue }
    }
}
