//
//  CoinPriceModelTests.swift
//  Coin
//
//  Created by Achem Samuel on 3/14/25.
//

import XCTest
@testable import Coin

final class CoinPriceModelTests: XCTestCase {
    
    func test_CoinHistoryItem_DisplayPrice_ValidNumber() {
        let item = CoinHistoryItem(price: "1234.56", timestamp: 1618317040)
        XCTAssertEqual(item.displayPrice, 1234.56, "Display price should correctly convert to Double")
    }
    
    func test_CoinHistoryItem_DisplayPrice_InvalidNumber() {
        let item = CoinHistoryItem(price: "invalid", timestamp: 1618317040)
        XCTAssertEqual(item.displayPrice, 0.0, "Invalid price strings should return 0.0")
    }
    
    func test_CoinHistoryData_Decoding() {
        let json = """
        {
            "change": "2.5",
            "history": [
                { "price": "50000.12", "timestamp": 1618317040 },
                { "price": "49000.00", "timestamp": 1618230640 }
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let historyData = try decoder.decode(CoinHistoryData.self, from: json)
            XCTAssertEqual(historyData.change, "2.5", "Change should match JSON")
            XCTAssertEqual(historyData.history.count, 2, "History array count should match JSON")
            XCTAssertEqual(historyData.history[0].displayPrice, 50000.12, "First history item price should match")
            XCTAssertEqual(historyData.history[1].displayPrice, 49000.00, "Second history item price should match")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
    
    func test_RemoteCoinHistoryItem_Conversion() {
        let remoteItem = RemoteCoinHistoryItem(price: "45000.89", timestamp: 1618317040)
        let item = remoteItem.coinHistoryData
        
        XCTAssertEqual(item.price, "45000.89", "Price should be correctly mapped")
        XCTAssertEqual(item.timestamp, 1618317040, "Timestamp should be correctly mapped")
        XCTAssertEqual(item.displayPrice, 45000.89, "Display price should correctly convert to Double")
    }
    
    func test_RemoteCoinHistoryData_Conversion() {
        let remoteItem1 = RemoteCoinHistoryItem(price: "60000", timestamp: 1618317040)
        let remoteItem2 = RemoteCoinHistoryItem(price: "59000", timestamp: 1618230640)
        let remoteData = RemoteCoinHistoryData(change: "5.0", history: [remoteItem1, remoteItem2])
        
        let historyData = remoteData.coinHistoryData
        
        XCTAssertEqual(historyData.change, "5.0", "Change should be correctly mapped")
        XCTAssertEqual(historyData.history.count, 2, "History array count should match")
        XCTAssertEqual(historyData.history[0].displayPrice, 60000, "First history item should match")
        XCTAssertEqual(historyData.history[1].displayPrice, 59000, "Second history item should match")
    }
}
