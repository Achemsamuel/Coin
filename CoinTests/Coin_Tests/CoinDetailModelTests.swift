//
//  CoinDetailModelTests.swift
//  Coin
//
//  Created by Achem Samuel on 3/14/25.
//

import XCTest
@testable import Coin

final class CoinDetailTests: XCTestCase {
    
    func test_CoinDetail_Initialization() {
        let coinDetail = CoinDetail(
            uuid: "1",
            symbol: "BTC",
            name: "Bitcoin",
            description: "Bitcoin is a decentralized cryptocurrency.",
            color: "#F7931A",
            iconUrl: URL(string: "https://example.com/icon.png"),
            websiteUrl: URL(string: "https://bitcoin.org")!,
            links: [CoinLink(name: "Bitcoin Website", url: URL(string: "https://bitcoin.org"), type: "website")],
            supply: CoinSupply(confirmed: true, supplyAt: 1710282000, circulating: "19000000", total: "21000000", max: "21000000"),
            volume24h: "5000000000",
            marketCap: "900000000000",
            fullyDilutedMarketCap: "1000000000000",
            price: "45000",
            btcPrice: "1",
            priceAt: 1710282000,
            change: "5.5",
            rank: 1,
            numberOfMarkets: 500,
            numberOfExchanges: 100,
            allTimeHigh: AllTimeHigh(price: "69000", timestamp: 1635972000),
            coinrankingUrl: URL(string: "https://coinranking.com/coin/1"),
            lowVolume: false,
            listedAt: 1367107200,
            notices: [CoinNotice(type: "update", value: "New Bitcoin update available")],
            tags: ["cryptocurrency", "decentralized"]
        )
        
        XCTAssertEqual(coinDetail.uuid, "1")
        XCTAssertEqual(coinDetail.symbol, "BTC")
        XCTAssertEqual(coinDetail.name, "Bitcoin")
        XCTAssertEqual(coinDetail.rank, 1)
        XCTAssertEqual(coinDetail.price, "45000")
        XCTAssertEqual(coinDetail.change, "5.5")
        XCTAssertEqual(coinDetail.supply.max, "21000000")
        XCTAssertEqual(coinDetail.links.first?.name, "Bitcoin Website")
    }
    
    func test_CoinDetail_DisplayMarketCap() {
        let coinDetail = CoinDetail(
            uuid: "1",
            symbol: "BTC",
            name: "Bitcoin",
            description: "Bitcoin is a decentralized cryptocurrency.",
            color: "#F7931A",
            iconUrl: nil,
            websiteUrl: URL(string: "https://bitcoin.org")!,
            links: [],
            supply: .dummy,
            volume24h: "5000000000",
            marketCap: "900000000000",
            fullyDilutedMarketCap: "1000000000000",
            price: "45000",
            btcPrice: "1",
            priceAt: 1710282000,
            change: "5.5",
            rank: 1,
            numberOfMarkets: 500,
            numberOfExchanges: 100,
            allTimeHigh: .dummy,
            coinrankingUrl: nil,
            lowVolume: false,
            listedAt: 1367107200,
            notices: [],
            tags: []
        )

        XCTAssertEqual(coinDetail.displayMarketCap, "$900,000,000,000".currencyStripped.currencyFormatted(symbol: "$"))
        XCTAssertEqual(coinDetail.displayVolume24h, "$5,000,000,000".currencyStripped.currencyFormatted(symbol: "$"))
    }
    
    func test_RemoteCoinDetail_Conversion() {
        let remoteCoinDetail = RemoteCoinDetail(
            uuid: "1",
            symbol: "BTC",
            name: "Bitcoin",
            description: "Bitcoin is a decentralized cryptocurrency.",
            color: "#F7931A",
            iconUrl: "https://example.com/icon.png",
            websiteUrl: "https://bitcoin.org",
            links: [RemoteCoinLink(name: "Bitcoin Website", url: "https://bitcoin.org", type: "website")],
            supply: RemoteCoinSupply(confirmed: true, supplyAt: 1710282000, circulating: "19000000", total: "21000000", max: "21000000"),
            volume24h: "5000000000",
            marketCap: "900000000000",
            fullyDilutedMarketCap: "1000000000000",
            price: "45000",
            btcPrice: "1",
            priceAt: 1710282000,
            change: "5.5",
            rank: 1,
            numberOfMarkets: 500,
            numberOfExchanges: 100,
            sparkline: [],
            allTimeHigh: RemoteAllTimeHigh(price: "69000", timestamp: 1635972000),
            coinrankingUrl: "https://coinranking.com/coin/1",
            lowVolume: false,
            listedAt: 1367107200,
            notices: [RemoteCoinNotice(type: "update", value: "New Bitcoin update available")],
            contractAddresses: [], tags: ["cryptocurrency", "decentralized"]
        )
        
        let coinDetail = remoteCoinDetail.coinDetail
        
        XCTAssertEqual(coinDetail.uuid, "1")
        XCTAssertEqual(coinDetail.symbol, "BTC")
        XCTAssertEqual(coinDetail.name, "Bitcoin")
        XCTAssertEqual(coinDetail.marketCap, "900000000000")
        XCTAssertEqual(coinDetail.displayMarketCap, "$900,000,000,000".currencyStripped.currencyFormatted(symbol: "$"))
        XCTAssertEqual(coinDetail.displayVolume24h, "$5,000,000,000".currencyStripped.currencyFormatted(symbol: "$"))
        XCTAssertEqual(coinDetail.allTimeHigh.price, "69000")
        XCTAssertEqual(coinDetail.rank, 1)
        XCTAssertEqual(coinDetail.links.first?.name, "Bitcoin Website")
        XCTAssertEqual(coinDetail.notices.first?.value, "New Bitcoin update available")
    }
}
