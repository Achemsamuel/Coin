//
//  CoinDetail.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import Foundation

// MARK: - Coin Detail Model
struct CoinDetail {
    let uuid: String
    let symbol: String
    let name: String
    let description: String
    let color: String
    let iconUrl: URL?
    let websiteUrl: URL?
    let links: [CoinLink]
    let supply: CoinSupply
    let volume24h: String
    let marketCap: String
    let fullyDilutedMarketCap: String
    let price: String
    let btcPrice: String
    let priceAt: Int
    let change: String
    let rank: Int
    let numberOfMarkets: Int
    let numberOfExchanges: Int
    let allTimeHigh: AllTimeHigh
    let coinrankingUrl: URL?
    let lowVolume: Bool
    let listedAt: Int
    let notices: [CoinNotice]
    let tags: [String]
}

// MARK: - Coin Link Model
struct CoinLink {
    let name: String
    let url: URL?
    let type: String
}

// MARK: - Coin Supply Model
struct CoinSupply {
    let confirmed: Bool
    let supplyAt: Int
    let circulating: String
    let total: String
    let max: String?
    
    static var dummy: Self {
        CoinSupply(confirmed: false, supplyAt: 0, circulating: "", total: "", max: "")
    }
}

// MARK: - All Time High Model
struct AllTimeHigh {
    let price: String
    let timestamp: Int
    
    static var dummy: Self {
        AllTimeHigh(price: "", timestamp: 0)
    }
}

//MARK: - Coin Notice Model
struct CoinNotice {
    let type: String
    let value: String
}


//MARK: Model Conversions
extension RemoteCoinLink {
    var coinLink: CoinLink {
        CoinLink(name: name ?? "", url: url?.url, type: type ?? "")
    }
}

extension RemoteCoinSupply {
    var coinSupply: CoinSupply {
        CoinSupply(confirmed: confirmed ?? false,
                   supplyAt: supplyAt ?? 0,
                   circulating: circulating ?? "",
                   total: total ?? "",
                   max: max ?? "")
    }
}

extension RemoteAllTimeHigh {
    var allTimeHigh: AllTimeHigh {
        AllTimeHigh(price: price ?? "", timestamp: timestamp ?? 0)
    }
}

extension RemoteCoinNotice {
    var notice: CoinNotice {
        CoinNotice(type: type ?? "", value: value ?? "")
    }
}

extension RemoteCoinDetail {
    var coinDetail: CoinDetail {
        CoinDetail(uuid: uuid ?? "",
                   symbol: symbol ?? "",
                   name: name ?? "",
                   description: description ?? "",
                   color: color ?? "", iconUrl: iconUrl?.url,
                   websiteUrl: websiteUrl?.url,
                   links: (links ?? []).map{ $0.coinLink },
                   supply: supply?.coinSupply ?? .dummy,
                   volume24h: volume24h ?? "",
                   marketCap: marketCap ?? "",
                   fullyDilutedMarketCap: fullyDilutedMarketCap ?? "",
                   price: price ?? "",
                   btcPrice: btcPrice ?? "",
                   priceAt: priceAt ?? 0,
                   change: change ?? "",
                   rank: rank ?? -1,
                   numberOfMarkets: numberOfMarkets ?? 0,
                   numberOfExchanges: numberOfExchanges ?? 0,
                   allTimeHigh: allTimeHigh?.allTimeHigh ?? .dummy,
                   coinrankingUrl: coinrankingUrl?.url,
                   lowVolume: lowVolume ?? false,
                   listedAt: listedAt ?? 0,
                   notices: (notices ?? []).map{ $0.notice },
                   tags: tags ?? [])
    }
}

enum SortOption: String {
    case price, marketCap, performance, none
    
    var title: String {
        switch self {
        case .price:
            return "Sort by Price"
        case .marketCap:
            return "Sort by Market Cap"
        case .performance:
            return "Sort by 24h Performance"
        case .none:
            return "Default"
        }
    }
    
    static var allCases: [SortOption] = [.price, .performance, .marketCap, .none]
}
