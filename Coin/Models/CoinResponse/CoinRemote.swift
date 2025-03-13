//
//  CoinRemote.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import Foundation

// MARK: - Root Response
struct CoinRemoteResponse: Decodable {
    let status: Status
    let data: CoinRemoteData?
    
    enum Status: String, Codable {
        case success
        case fail
    }
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}

// MARK: - Data Section
struct CoinRemoteData: Decodable {
    let stats: CoinRemoteStats?
    let coins: [CoinRemote]?
    
    enum CodingKeys: String, CodingKey {
        case stats
        case coins
    }
}

// MARK: - Statistics Section
struct CoinRemoteStats: Decodable {
    let total: Int?
    let totalCoins: Int?
    let totalMarkets: Int?
    let totalExchanges: Int?
    let totalMarketCap: String?
    let total24hVolume: String?
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalCoins
        case totalMarkets
        case totalExchanges
        case totalMarketCap
        case total24hVolume
    }
}

// MARK: - Coin Model
struct CoinRemote: Decodable {
    let uuid: String?
    let symbol: String?
    let name: String?
    let color: String?
    let iconUrl: String?
    let marketCap: String?
    let price: String?
    let listedAt: Int?
    let tier: Int?
    let change: String?
    let rank: Int?
    let sparkline: [String?]?
    let lowVolume: Bool?
    let coinrankingUrl: String?
    let volume24h: String?
    let btcPrice: String?
    let contractAddresses: [String?]?
    
    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color, iconUrl, marketCap, price, listedAt, change, rank, sparkline, lowVolume, coinrankingUrl, btcPrice, contractAddresses
        case volume24h = "24hVolume"
        case tier
    }
}
