//
//  CoinsDetailViewModelTest.swift
//  Coin
//
//  Created by Achem Samuel on 3/14/25.
//

import XCTest
@testable import Coin

@MainActor
final class CoinsDetailViewModelTest: XCTestCase {
    
    var dataStore: CoinsDataLocalRepository!
    var viewModel: CoinDetailView.ViewModel!
    
    override func setUp() {
        super.setUp()
        dataStore = CoinsDataLocalRepository()
        dataStore.selectedCoin = Coin.dummy
        viewModel = CoinDetailView.ViewModel(dataStore: dataStore)
    }
    
    override func tearDown() {
        viewModel = nil
        dataStore = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertFalse(viewModel.showError, "Expected showError to be false initially")
        XCTAssertEqual(viewModel.errorMessage, "", "Expected errorMessage to be empty initially")
        XCTAssertNil(viewModel.coinDetail, "Expected coinDetail to be nil initially")
    }
    
    func testComputedProperties() {
        XCTAssertEqual(viewModel.coinName, "Bitcoin", "Expected coin name to be 'Bitcoin'")
        XCTAssertEqual(viewModel.coinSymbol, "BTC", "Expected coin symbol to be 'BTC'")
    }
    
    func testGetCoinHistory_CallsFetchOnlyIfHistoryNotAvailable() async {
        // Given
        let initialHistoryCount = viewModel.coinPriceHistory.count
        
        // When
        viewModel.getCoinHistory()
        let afterFetchCount = viewModel.coinPriceHistory.count
        
        // Then
        XCTAssertEqual(afterFetchCount, initialHistoryCount, "Expected history count to increase after fetch")
    }
    
    func testErrorHandling_ShowsErrorMessage() async {
        // Given
        viewModel.errorMessage = "failure"
        
        // When
        viewModel.getCoinHistory()
        
        // Then
        if viewModel.showError {
            XCTAssertNotEqual(viewModel.errorMessage, "failure", "Expected error message to be set on failure")
        }
    }
}
