//
//  CoinApp.swift
//  Coin
//
//  Created by Achem Samuel on 3/12/25.
//

import SwiftUI

@main
struct CoinApp: App {
    @AppStorage("userLoggedIn") var userLoggedIn: Bool = false
    @StateObject private var coinsDataLocalRepository: CoinsDataLocalRepository = .init()

    var body: some Scene {
        WindowGroup {
            if userLoggedIn {
                CoinListView(dataStore: coinsDataLocalRepository)
            } else {
                LandingView {
                    userLoggedIn = true
                }
                .ignoresSafeArea(.all)
            }
        }
    }
}
