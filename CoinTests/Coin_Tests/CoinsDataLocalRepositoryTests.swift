//
//  CoinsDataLocalRepository+XCTest.swift
//  Coin
//
//  Created by Achem Samuel on 3/14/25.
//

import XCTest
@testable import Coin

final class CoinsDataLocalRepositoryTests: XCTestCase {
    
    var repository: CoinsDataLocalRepository!
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.favorites = [] // Reset UserDefaults
        repository = CoinsDataLocalRepository()
    }
    
    override func tearDown() {
        repository = nil
        UserDefaults.standard.favorites = [] // Clean up
        super.tearDown()
    }
    
    func testInitializationLoadsFavorites() {
        // Given stored favorites
        UserDefaults.standard.favorites = ["Qwsogvtv82FCd", "coin2"]
        
        // When repository is initialized
        repository = CoinsDataLocalRepository()
        
        // Then it should load favorites
        XCTAssertEqual(repository.favorites, ["Qwsogvtv82FCd", "coin2"])
    }
    
    func testToggleFavorite_AddsAndRemovesFavorite() {
        let uuid = "Qwsogvtv82FCd"
        let coin = Coin.dummy
        repository.coins.insert(coin)
        
        // When adding to favorites
        repository.toggleFavorite(with: uuid)
        XCTAssertTrue(repository.isFavorite(id: uuid))
        XCTAssertTrue(repository.favoriteCoins.contains(coin))
        
        // When removing from favorites
        repository.toggleFavorite(with: uuid)
        XCTAssertFalse(repository.isFavorite(id: uuid))
        XCTAssertFalse(repository.favoriteCoins.contains(coin))
    }
    
    func testPrepareFavoriteCoins() {
        let coin1 = Coin.dummy
        let coin2 = Coin.dummy
        
        repository.coins = [coin1, coin2]
        repository.favorites = ["Qwsogvtv82FCd"]
        
        repository.prepareFavoriteCoins()
        
        XCTAssertEqual(repository.favoriteCoins, [coin1, coin2])
    }
    
    func testIsFavorite_ReturnsCorrectValue() {
        repository.favorites.insert("Qwsogvtv82FCd")
        
        XCTAssertTrue(repository.isFavorite(id: "Qwsogvtv82FCd"))
        XCTAssertFalse(repository.isFavorite(id: "doge"))
    }
}
