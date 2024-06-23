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
}

extension FirestoreClient: DependencyKey {
    static let liveValue = Self (
        fetchStocks: { thema in
            return try await firestoreManager.fetchStocks(thema: thema)
        }
    )
    static let testValue = Self (
        fetchStocks: { thema in
            return try await mockFirestoreManager.fetchStocks(thema: thema)
        }
    )
}

extension DependencyValues {
    var firestoreClient: FirestoreClient {
        get { self[FirestoreClient.self] }
        set { self[FirestoreClient.self] = newValue }
    }
}
