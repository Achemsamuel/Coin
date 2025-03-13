//
//  CoinPriceRemote.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

struct RemoteCoinHistoryResponse: Codable {
    let status: String?
    let data: RemoteCoinHistoryData?
}

// MARK: - Data Model
struct RemoteCoinHistoryData: Codable {
    let change: String?
    let history: [RemoteCoinHistoryItem]?
}

// MARK: - History Item Model
struct RemoteCoinHistoryItem: Codable {
    let price: String?
    let timestamp: Int?
}
