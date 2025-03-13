//
//  CoinsDataLocalRepository.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//
import SwiftUI

final class CoinsDataLocalRepository: ObservableObject {
    @Published var favorites: Set<String> = []
    @Published var coins: Set<Coin> = []
    @Published var favoriteCoins: Set<Coin> = []
    @Published var selectedCoin: Coin?
    
    init() {
        setup()
    }
    
    private func setup() {
        favorites.formUnion(UserDefaults.standard.favorites)
    }
    
    func toggleFavorite(with id: String) {
        defer {
            UserDefaults.standard.favorites = Array(favorites)
        }
        
        if favorites.contains(id) {
            favorites = favorites.filter{$0 != id}
            if let coin = coins.first(where: {$0.uuid == id}) {
                favoriteCoins.remove(coin)
            }
        } else {
            favorites.insert(id)
            if let coin = coins.first(where: {$0.uuid == id}) {
                favoriteCoins.insert(coin)
            }
        }
    }
    
    func isFavorite(id: String) -> Bool {
        favorites.contains(id)
    }
    
    func prepareFavoriteCoins() {
        favoriteCoins = coins.filter{ favorites.contains($0.uuid) }
    }
}
