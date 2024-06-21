//
//  FirestoreManager.swift
//  HiStock
//
//  Created by 송우진 on 6/20/24.
//
import FirebaseFirestore

protocol FirestoreManaging {
    func fetchStocks(thema: String) async throws -> [Stock]
}

final class FirestoreManager: FirestoreManaging {
    private let db = Firestore.firestore()
    
    // 특정 테마를 포함한 주식 조회
    func fetchStocks(thema: String) async throws -> [Stock] {
        let querySnapshot = try await db.collection("stock").whereField("themas", arrayContainsAny: [thema]).getDocuments()
        return try querySnapshot.documents.map({ try $0.data(as: Stock.self )})
    }

}
