//
//  CoinModel.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//
import SwiftUI
import Foundation

// MARK: - Data Section
struct CoinData {
    let stats: CoinStats
    let coins: [Coin]
}

// MARK: - Statistics Section
struct CoinStats {
    let total: Int
    let totalCoins: Int
    let totalMarkets: Int
    let totalExchanges: Int
    let totalMarketCap: String
    let total24hVolume: String
}

// MARK: - Coin Model
struct Coin: Hashable {
    let id: UUID = .init()
    let uuid: String
    let symbol: String
    let name: String
    let color: String
    let iconUrl: URL
    let marketCap: String
    let price: String
    let listedAt: Int
    let change: String
    let rank: Int
    let lowVolume: Bool
    let coinrankingUrl: String
    let volume24h: String
    let btcPrice: String
    var isFavorite: Bool
    
    var displayPrice: String {
        price.currencyFormatted(symbol: "$", decimalPlaces: 2)
    }
    
    private var positiveChange: Bool {
        if let changeDouble = Double(change) {
            return changeDouble >= 0
        } else {
            return true
        }
    }
    
    var changeColor: Color {
        positiveChange ? .green : .red
    }
    
    var absChange: String {
        if let changeDouble = Double(change) {
            return "\(abs(changeDouble))"
        } else {
            return change
        }
    }
    
    var displayChange: String {
        positiveChange ? "+\(change)" : "\(change)"
    }
    
    var priceDouble: Double {
        Double(price.currencyStripped) ?? 0
    }
    
    var marketCapDouble: Double {
        Double(marketCap) ?? 0
    }
    
    var volume24hDouble: Double {
        Double(volume24h) ?? 0
    }
    
    static var dummy: Coin {
        Coin(uuid: "Qwsogvtv82FCd",
             symbol: "BTC",
             name: "Bitcoin",
             color: "",
             iconUrl: URL(string: "https://cdn.coinranking.com/Sy33Krudb/btc.svg")!,
             marketCap: "159393904304",
             price: "500.45",
             listedAt: 100,
             change: "-5.9",
             rank: 1,
             lowVolume: false,
             coinrankingUrl: "",
             volume24h: "433448746484844",
             btcPrice: "1",
             isFavorite: false)
    }
}


extension CoinRemoteData {
    func toCoinData(favorites: [String] = []) -> CoinData {
        let stats = stats?.toCoinStats() ?? CoinStats(total: 0, totalCoins: 0, totalMarkets: 0, totalExchanges: 0, totalMarketCap: "", total24hVolume: "")
        let coins = (coins ?? []).map { $0.toCoin(favorites: favorites) }
        return CoinData(stats: stats, coins: coins)
    }
}

extension CoinRemoteStats {
    func toCoinStats() -> CoinStats {
        CoinStats(total: total ?? 0,
                  totalCoins: totalCoins ?? 0,
                  totalMarkets: totalMarkets ?? 0,
                  totalExchanges: totalExchanges ?? 0,
                  totalMarketCap: totalMarketCap ?? "",
                  total24hVolume: total24hVolume ?? "")
    }
}

extension CoinRemote {
    func toCoin(favorites: [String] = []) -> Coin {
        Coin(uuid: uuid ?? "",
             symbol: symbol ?? "",
             name: name ?? "",
             color: color ?? "",
             iconUrl: (URL(string: iconUrl ?? "") ?? URL(string: "https://cdn.coinranking.com/Sy33Krudb/btc.svg")!),
             marketCap: marketCap ?? "",
             price: price ?? "",
             listedAt: listedAt ?? 0,
             change: change ?? "",
             rank: rank ?? -1,
             lowVolume: lowVolume ?? false,
             coinrankingUrl: coinrankingUrl ?? "",
             volume24h: volume24h ?? "",
             btcPrice: btcPrice ?? "",
             isFavorite: favorites.contains(uuid ?? ""))
    }
}
