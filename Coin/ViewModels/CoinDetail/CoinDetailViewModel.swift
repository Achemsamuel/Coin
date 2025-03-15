//
//  CoinDetailViewModel.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import Foundation
import SwiftUI

extension CoinDetailView {
    enum TimeFrame: CaseIterable {
        case day
        case week
        case month
        case year
        
        var title: String {
            switch self {
            case .day:
                return "24h"
            case .week:
                return "7d"
            case .month:
                return "30d"
            case .year:
                return "1y"
            }
        }
        
        var xAxisTitle: String {
            switch self {
            case .day:
                return "Time"
            case .week:
                return "Day"
            case .month:
                return "Week"
            case .year:
                return "Month"
            }
        }
        
        var yAxisTitle: String {
            return "Price (USD)"
        }
    }
    
    @MainActor final class ViewModel: ObservableObject {
        @ObservedObject private(set) var dataStore: CoinsDataLocalRepository
        @Published var showLoader: Bool = false
        @Published var errorMessage: String = ""
        @Published var showError: Bool = false
        @Published var coinPriceHistory: [TimeFrame: [CoinHistoryItem]] = [:]
        @Published var coinDetail: CoinDetail?
        @Published var change: String = ""
        @Published var selectedTimeframe: TimeFrame = .day {
            didSet {
                getCoinHistory()
            }
        }
        
        private lazy var apiClient: CoinApi = .client
        private var modelSetup: Bool = false
        
        var history: [CoinHistoryItem] {
            coinPriceHistory[selectedTimeframe] ?? []
        }
        
        var coin: Coin {
            dataStore.selectedCoin ?? .dummy
        }
        
        var coinName: String {
            coin.name
        }
        
        var coinSymbol: String {
            coin.symbol
        }
        
        init(dataStore: CoinsDataLocalRepository) {
            self.dataStore = dataStore
        }
        
        func setup() {
            guard !modelSetup else { return }
            getCoinDetail()
            modelSetup = true
        }
        
        private func getCoinDetail() {
            let coinId = coin.uuid
            guard !coinId.isEmpty else { return }
            showLoader = true
            Task {
                do {
                    let detailResponse = try await apiClient.getCoinDetail(id: coinId, returning: RemoteCoinDetailResponse.self)
                    runOnMainThread { [weak self] in
                        guard let self else { return }
                        let detail = detailResponse?.data.coin.coinDetail
                        coinDetail = detail
                        showLoader = false
                        fetchCoinPriceHistory()
                    }
                } catch {
                    runOnMainThread { [weak self] in
                        guard let self else { return }
                        showLoader = false
                        showError = true
                        errorMessage = error.localizedDescription
                    }
                }
            }
        }
        
        private func fetchCoinPriceHistory() {
            let coinId = coin.uuid
            guard !coinId.isEmpty else { return }
            showLoader = true
            Task {
                do {
                    let historyResponse = try await apiClient.getPriceHistory(id: coinId, timeFrame: selectedTimeframe.title, returning: RemoteCoinHistoryResponse.self)
                    runOnMainThread { [weak self] in
                        guard let self else { return }
                        let history = historyResponse?.data?.coinHistoryData
                        change = history?.change ?? ""
                        coinPriceHistory[selectedTimeframe] = history?.history ?? []
                        showLoader = false
                    }
                } catch {
                    runOnMainThread { [weak self] in
                        guard let self else { return }
                        showLoader = false
                        showError = true
                        errorMessage = error.localizedDescription
                    }
                }
            }
        }
        
        func getCoinHistory() {
            guard coinPriceHistory[selectedTimeframe] == nil else { return }
            fetchCoinPriceHistory()
        }
        
        deinit {
            print(#function, #fileID)
        }
    }
}
