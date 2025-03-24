//
//  CoinNetworking.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//
import CoinNetworking
import Foundation

protocol CoinApiInterface {
    func get<T: Decodable>(limit: Int,
                           offset: Int,
                           parameters: Parameters,
                           returning objectType: T.Type) async throws -> T?
    
    func getCoinDetail<T: Decodable>(id: String,
                                       parameters: Parameters,
                           returning objectType: T.Type) async throws -> T?
    
    func getPriceHistory<T: Decodable>(id: String,
                                       timeFrame: String,
                           returning objectType: T.Type) async throws -> T?
    
    func post<T: Decodable>(url: URL?,
                           parameters: Parameters,
                           returning objectType: T.Type) async throws -> T?
}

final class CoinApi: CoinNetworkingService, CoinApiInterface, @unchecked Sendable  {
    static let client = CoinApi()
    private lazy var baseApiUrlString = Bundle.main.coinApiUrlString
    
    private override init() {
        super.init()
        setupHeader()
    }
    
    private func setupHeader() {
        let apiKey = Bundle.main.coinApiKey
        guard !apiKey.isEmpty else {
            fatalError("Could not load api key from bundle".localized)
        }
        
        super.addHeaders(["x-access-token": apiKey])
    }
    
    func get<T: Decodable>(limit: Int = 20,
                           offset: Int = 0,
                           parameters: Parameters = [:],
                           returning objectType: T.Type) async throws -> T? {
        let url = URL(string: "\(baseApiUrlString)?limit=\(limit)&offset=\(offset)")
        let method: HTTPMethod = .get
        return try await super.makeRequest(url: url, parameters: parameters, method: method, returning: objectType)
    }
    
    func getCoinDetail<T: Decodable>(id: String,
                                       parameters: Parameters = [:],
                           returning objectType: T.Type) async throws -> T? {
        let url = URL(string: "\(baseApiUrlString)/coin/\(id)")
        let method: HTTPMethod = .get
        return try await super.makeRequest(url: url, parameters: parameters, method: method, returning: objectType)
    }
    
    func getPriceHistory<T: Decodable>(id: String,
                                       timeFrame: String = "24h",
                           returning objectType: T.Type) async throws -> T? {
        let url = URL(string: "\(baseApiUrlString)/\(id)/history?timePeriod=\(timeFrame)")
        let method: HTTPMethod = .get
        return try await super.makeRequest(url: url, parameters: [:], method: method, returning: objectType)
    }
    
    func post<T: Decodable>(url: URL?,
                           parameters: Parameters = [:],
                           returning objectType: T.Type) async throws -> T? {
        let method: HTTPMethod = .post
        return try await super.makeRequest(url: url, parameters: parameters, method: method, returning: objectType)
    }
}
