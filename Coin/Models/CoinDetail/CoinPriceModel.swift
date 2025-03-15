//
//  CoinPriceModel.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import Foundation

struct CoinHistoryData: Codable {
    let change: String
    let history: [CoinHistoryItem]
}

// MARK: - History Item Model
struct CoinHistoryItem: Codable {
    let price: String
    let timestamp: Int
    
    var displayPrice: Double {
        Double(price) ?? 0
    }
    
    var date: Date {
        Date(timeIntervalSince1970: Double(timestamp))
    }
}

extension RemoteCoinHistoryItem {
    var coinHistoryData: CoinHistoryItem {
        CoinHistoryItem(price: price ?? "", timestamp: timestamp ?? 0)
    }
}

extension RemoteCoinHistoryData {
    var coinHistoryData: CoinHistoryData {
        CoinHistoryData(change: change ?? "", history: (history ?? []).map{ $0.coinHistoryData })
    }
}
