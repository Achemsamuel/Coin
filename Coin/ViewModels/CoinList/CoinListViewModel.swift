//
//  CoinListViewModel.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import Foundation
import SwiftUI

extension CoinListView {
    @MainActor final class ViewModel: ObservableObject {
        @ObservedObject private(set) var dataStore: CoinsDataLocalRepository
        @Published var showLoader: Bool = false
        @Published var dotCount = 0
        let maxDots = 3
        let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
        @Published var errorMessage: String = ""
        @Published var showError: Bool = false
        @Published var searchQuery: String = ""
        @Published var isLoadingMoreCoins: Bool = false
        @Published var sortOption: SortOption = .none
        
        private lazy var apiClient: CoinApi = .client
        private var limit: Int = 20
        private var offset: Int = 0
        private var totalCoinsCount: Int = 0
        
        var filteredList: [Coin] {
            if searchQuery.isEmpty {
                let value = sort(Array(dataStore.coins).sorted{ $1.rank > $0.rank })
                return value
            } else {
                let coins = dataStore.coins.filter {
                    $0.name.lowercased().contains(searchQuery.lowercased())
                    || $0.symbol.lowercased().contains(searchQuery.lowercased())
                }.sorted{ $1.rank > $0.rank }
                let value = sort(coins)
                return value
            }
        }
        
        init(dataStore: CoinsDataLocalRepository) {
            self.dataStore = dataStore
        }
        
        var canLoadMore: Bool {
            dataStore.coins.count < totalCoinsCount
        }
        
        func prefetchCoins() {
            guard dataStore.coins.isEmpty else { return }
            fetchCoins()
        }
        
        private func fetchCoins(offset: Int = 0, limit: Int = 20) {
            showLoader = true
            Task {
                do {
                    let coinResponse = try await apiClient.get(limit: limit, offset: offset, returning: CoinRemoteResponse.self)
                    runOnMainThread { [weak self] in
                        guard let self else { return }
                        let coinsArray = coinResponse?.data?.toCoinData(favorites: Array(dataStore.favorites)).coins ?? []
                        self.offset = offset
                        dataStore.coins.formUnion(coinsArray)
                        totalCoinsCount = coinResponse?.data?.stats?.totalCoins ?? 0
                        reset()
                    }
                } catch {
                    runOnMainThread { [weak self] in
                        guard let self else { return }
                        showLoader = false
                        showError = true
                        isLoadingMoreCoins = false
                        errorMessage = error.localizedDescription
                    }
                }
            }
        }
        
        func prefetchMoreCoins() {
            guard !isLoadingMoreCoins && canLoadMore && searchQuery.isEmpty else { return }
            isLoadingMoreCoins = true
            
            runAfter(1) { [weak self] in
                guard let self else { return }
                fetchCoins(offset: offset + 20)
            }
        }
        
        func verifyCoinPosition(via coin: Coin) {
            if coin.uuid == filteredList.last?.uuid {
                //Fetching more coins
                prefetchMoreCoins()
            }
        }
        
        func reset() {
            isLoadingMoreCoins = false
            showLoader = false
            showError = false
        }
        
        private func sort(_ coins: [Coin]) -> [Coin] {
            switch sortOption {
            case .price:
                return coins.sorted{ $1.priceDouble < $0.priceDouble }
            case .marketCap:
                return coins.sorted{ $1.marketCapDouble < $0.marketCapDouble }
            case .performance:
                return coins.sorted{ $1.volume24hDouble < $0.volume24hDouble }
            case .none:
                return coins
            }
        }
        
        deinit {
            print(#function, #fileID)
        }
    }
}
