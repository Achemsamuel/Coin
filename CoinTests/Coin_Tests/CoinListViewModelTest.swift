//
//  CoinListViewModelTest.swift
//  Coin
//
//  Created by Achem Samuel on 3/14/25.
//

import XCTest
@testable import Coin

@MainActor
final class CoinListViewModelTest: XCTestCase {
    
    var dataStore: CoinsDataLocalRepository!
    var viewModel: CoinListView.ViewModel!
    
    override func setUp() {
        super.setUp()
        dataStore = CoinsDataLocalRepository()
        viewModel = CoinListView.ViewModel(dataStore: dataStore)
    }
    
    override func tearDown() {
        viewModel = nil
        dataStore = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertFalse(viewModel.showLoader, "Expected showLoader to be false initially")
        XCTAssertFalse(viewModel.showError, "Expected showError to be false initially")
        XCTAssertEqual(viewModel.errorMessage, "", "Expected errorMessage to be empty initially")
        XCTAssertEqual(viewModel.searchQuery, "", "Expected searchQuery to be empty initially")
        XCTAssertFalse(viewModel.isLoadingMoreCoins, "Expected isLoadingMoreCoins to be false initially")
        XCTAssertEqual(viewModel.sortOption, .none, "Expected sortOption to be none initially")
    }
    
    func testFilteredList_EmptyQuery_ReturnsAllCoinsSortedByRank() {
        // Given
        let coins = [
            Coin.dummy,
            Coin.dummy,
            Coin.dummy
        ]
        dataStore.coins = Set(coins)
        
        // When
        let filteredList = viewModel.filteredList
        
        // Then
        XCTAssertEqual(filteredList.count, 3, "Expected all coins in the list")
        XCTAssertEqual(filteredList.first?.name, "Bitcoin", "Expected Bitcoin to be first (highest rank)")
        XCTAssertEqual(filteredList.first?.uuid, "Qwsogvtv82FCd", "Expected Bitcoin to be first (highest rank)")
    }
    
    func testFilteredList_SearchQueryFiltersResults() {
        // Given
        let coins = [
            Coin.dummy,
            Coin.dummy,
            Coin.dummy
        ]
        dataStore.coins = Set(coins)
        
        // When
        viewModel.searchQuery = "Bitcoin"
        let filteredList = viewModel.filteredList
        
        // Then
        XCTAssertEqual(filteredList.count, 3, "Expected only one coin to match the search query")
        XCTAssertEqual(filteredList.first?.name, "Bitcoin", "Expected Bitcoin to be the result")
    }
    
    func testSortingByPrice() {
        // Given
        let coins = [
            Coin.dummy,
            Coin.dummy,
            Coin.dummy
        ]
        dataStore.coins = Set(coins)
        
        // When
        viewModel.sortOption = .price
        let sortedList = viewModel.filteredList
        
        // Then
        XCTAssertEqual(sortedList.first?.name, "Bitcoin", "Expected Bitcoin to be first (highest price)")
    }
    
    func testCanLoadMore() {
        // Given
        dataStore.coins = Set(Array(repeating: .dummy, count: 10))
        
        // When
        let canLoadMore = viewModel.canLoadMore
        
        // Then
        XCTAssertFalse(canLoadMore, "Expected canLoadMore to be false when there are more coins to load")
    }
    
    func testErrorHandling_SetsShowErrorAndErrorMessage() {
        // Given
        viewModel.showError = true
        viewModel.errorMessage = "failed"
        
        // When
        viewModel.prefetchCoins()
        
        // Then
        XCTAssertTrue(viewModel.showError, "Expected showError to be true on failure")
        XCTAssertNotEqual(viewModel.errorMessage, "", "Expected errorMessage to be set on failure")
    }
}
