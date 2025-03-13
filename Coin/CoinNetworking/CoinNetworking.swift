//
//  CoinNetworking.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//
import CoinNetworking
import Foundation

final class CoinApi: CoinNetworkingService, @unchecked Sendable  {
    static let client = CoinApi()
    
    private override init() {
        super.init()
        setupHeader()
    }
    
    private func setupHeader() {
        let apiKey = Bundle.main.coinApiKey
        guard !apiKey.isEmpty else {
            fatalError("Could not load api key from bundle")
        }
        
        super.addHeaders(["x-access-token": apiKey])
    }
    
    func get<T: Decodable>(limit: Int = 20,
                           offset: Int = 0,
                           parameters: Parameters = [:],
                           returning objectType: T.Type) async throws -> T? {
        let url = URL(string: "https://api.coinranking.com/v2/coins?limit=\(limit)&offset=\(offset)")
        let method: HTTPMethod = .get
        return try await super.makeRequest(url: url, parameters: parameters, method: method, returning: objectType)
    }
    
    func post<T: Decodable>(url: URL?,
                           parameters: Parameters = [:],
                           returning objectType: T.Type) async throws -> T? {
        let method: HTTPMethod = .post
        return try await super.makeRequest(url: url, parameters: parameters, method: method, returning: objectType)
    }
}
