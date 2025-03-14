//
//  NavigationItemTests.swift
//  Coin
//
//  Created by Achem Samuel on 3/14/25.
//

import XCTest
import SwiftUI
@testable import Coin

final class NavigationItemTests: XCTestCase {
    
    func test_NavigationItem_Hashable() {
        let coin1 = Coin.dummy
        let coin2 = Coin.dummy

        let item1 = NavigationItem.coinDetails(coin: coin1)
        let item2 = NavigationItem.coinDetails(coin: coin2)
        let item3 = NavigationItem.favorites

        XCTAssertNotEqual(item1, item2, "Different coin details should not be equal")
        XCTAssertNotEqual(item1, item3, "Coin details and favorites should not be equal")
        XCTAssertNotEqual(item2, item3, "Different navigation cases should not be equal")

        let hashSet: Set<NavigationItem> = [item1, item2, item3]
        XCTAssertEqual(hashSet.count, 3, "All items should be unique in a hash set")
    }

    func test_ViewFactory_Destination() {
        let dataStore = CoinsDataLocalRepository()
        let navigationPath = Binding<NavigationPath>(get: { NavigationPath() }, set: { _ in })

        let coin = Coin.dummy
        let coinDetailsView = ViewFactory.destination(for: .coinDetails(coin: coin), datastore: dataStore, path: navigationPath)
        let favoritesView = ViewFactory.destination(for: .favorites, datastore: dataStore, path: navigationPath)

        XCTAssert(coinDetailsView is AnyView, "Coin details view should be AnyView")
        XCTAssert(favoritesView is AnyView, "Favorites view should be AnyView")
    }
}
