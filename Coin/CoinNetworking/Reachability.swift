//
//  Reachability.swift
//  Coin
//
//  Created by Achem Samuel on 3/24/25.
//
import CoinNetworking

enum CoinReachability {
    static func checkInternetConnection() {
        _ = Reachability.isConnectedToNetwork()
    }
}
