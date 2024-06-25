//
//  FirestoreManager.swift
//  HiStock
//
//  Created by 송우진 on 6/20/24.
//
import FirebaseFirestore

protocol FirestoreManaging {
    func fetchStocks(thema: String) async throws -> [Stock]
    func fetchMakets() async throws -> [Market]
}

final class FirestoreManager: FirestoreManaging {
    private let db = Firestore.firestore()
    
    // 특정 테마를 포함한 주식 조회
    func fetchStocks(thema: String) async throws -> [Stock] {
        let querySnapshot = try await db.collection("stock").whereField("themas", arrayContainsAny: [thema]).getDocuments()
        return try querySnapshot.documents.map({ try $0.data(as: Stock.self )})
    }
    
    // 코스피, 코스닥 정보 조회
    func fetchMakets() async throws -> [Market] {
        let querySnapshot = try await db.collection("market").getDocuments()
        return try querySnapshot.documents.map({ try $0.data(as: Market.self )})
    }

}
