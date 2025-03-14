//
//  NavigationItem.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import SwiftUI

enum NavigationItem: Hashable {
    case coinDetails(coin: Coin)
    case favorites
}

struct ViewFactory {
    static func destination(for item: NavigationItem, datastore: CoinsDataLocalRepository, path: Binding<NavigationPath>) -> AnyView {
        switch item {
        case .coinDetails(let coin):
            return AnyView(CoinDetailView(dataStore: datastore))
        case .favorites:
            return AnyView(CoinFavoritesView(dataStore: datastore, navigationPath: path))
        }
    }
}
