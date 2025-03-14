//
//  CoinApiTest.swift
//  Coin
//
//  Created by Achem Samuel on 3/14/25.
//
import XCTest
@testable import Coin
import Foundation

final class CoinApiTests: XCTestCase {
    
    var coinApi: CoinApiTest!
    
    override func setUp() {
        super.setUp()
        coinApi = CoinApiTest()
    }
    
    override func tearDown() {
        coinApi = nil
        super.tearDown()
    }
    
    func testGetCoins_ReturnsDefault() async throws {
        // When
        let result: [String]? = await coinApi.get(limit: 2)
        XCTAssertGreaterThan((result ?? []).count, 1, "Expected at least one coin")
        
        // Then
        XCTAssertNotNil(result, "Expected non-nil response")
    }
    
    func testGetCoinDetail_ReturnsDefault() async throws {
        // When
        let result: String = await coinApi.getDetail()
        
        // Then
        XCTAssertNotNil(result, "Expected non-nil response")
        XCTAssertEqual(result, "bitcoin")
    }
    
    func testGetPriceHistory_ReturnsDefault() async throws {
        // When
        let result: [String] = await coinApi.getPriceHistory()
        
        // Then
        XCTAssertNotNil(result, "Expected non-nil response")
        XCTAssertGreaterThan(result.count, 0, "Expected at least one price entry")
    }
}
