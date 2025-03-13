//
//  CoinDetailRemote.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import Foundation

// MARK: - Main Response Model
struct RemoteCoinDetailResponse: Codable {
    let status: String
    let data: RemoteCoinData
}

// MARK: - Coin Data Model
struct RemoteCoinData: Codable {
    let coin: RemoteCoinDetail
}

// MARK: - Coin Detail Model
struct RemoteCoinDetail: Codable {
    let uuid: String?
    let symbol: String?
    let name: String?
    let description: String?
    let color: String?
    let iconUrl: String?
    let websiteUrl: String?
    let links: [RemoteCoinLink]?
    let supply: RemoteCoinSupply?
    let volume24h: String?
    let marketCap: String?
    let fullyDilutedMarketCap: String?
    let price: String?
    let btcPrice: String?
    let priceAt: Int?
    let change: String?
    let rank: Int?
    let numberOfMarkets: Int?
    let numberOfExchanges: Int?
    let sparkline: [String?]?
    let allTimeHigh: RemoteAllTimeHigh?
    let coinrankingUrl: String?
    let lowVolume: Bool?
    let listedAt: Int?
    let notices: [RemoteCoinNotice]?
    let contractAddresses: [String?]?
    let tags: [String]?
    
    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, description, color, iconUrl, websiteUrl, links, supply
        case volume24h = "24hVolume"
        case marketCap, fullyDilutedMarketCap, price, btcPrice, priceAt, change, rank
        case numberOfMarkets, numberOfExchanges, sparkline, allTimeHigh, coinrankingUrl
        case lowVolume, listedAt, notices, contractAddresses, tags
    }
}

// MARK: - Coin Link Model
struct RemoteCoinLink: Codable {
    let name: String?
    let url: String?
    let type: String?
}

// MARK: - Coin Supply Model
struct RemoteCoinSupply: Codable {
    let confirmed: Bool?
    let supplyAt: Int?
    let circulating: String?
    let total: String?
    let max: String?
}

// MARK: - All Time High Model
struct RemoteAllTimeHigh: Codable {
    let price: String?
    let timestamp: Int?
}

// MARK: - Coin Notice Model
struct RemoteCoinNotice: Codable {
    let type: String?
    let value: String?
}
