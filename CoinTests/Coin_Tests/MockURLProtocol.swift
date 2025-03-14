//
//  MockURLProtocol.swift
//  Coin
//
//  Created by Achem Samuel on 3/14/25.
//
import Foundation
import CoinNetworking

final class CoinApiTest: CoinNetworkingService, @unchecked Sendable {
    
    func get(limit: Int) async -> [String] {
        return ["1", "2"]
    }
    
    func getDetail() async -> String {
        return "bitcoin"
    }
    
    func getPriceHistory() async -> [String] {
        return ["1", "2", "3"]
    }
}
