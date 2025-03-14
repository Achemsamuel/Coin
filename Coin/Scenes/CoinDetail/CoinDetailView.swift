//
//  CoinDetailView.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//
import Charts
import SwiftUI

struct CoinDetailView: View {
    @StateObject private var viewModel: ViewModel
    
    init(dataStore: CoinsDataLocalRepository) {
        _viewModel = StateObject(wrappedValue: .init(dataStore: dataStore))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                headerSection
                
                if viewModel.coinPriceHistory.isEmpty {
                    ProgressView()
                } else {
                    performanceChart
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    additionalInfo
                    statisticsSection
                }
            }
            .padding(20)
        }
        .scrollIndicators(.hidden)
        .navigationTitle(viewModel.coinName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.coinBackground)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .lastTextBaseline, spacing: 10) {
                Text(viewModel.coinSymbol)
                    .font(.title)
                    .fontWeight(.bold)
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Text("\(viewModel.coinName) • Rank #\(viewModel.coin.rank)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .fontWeight(.regular)
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Spacer()
            }
            
            Divider()
            
            HStack(alignment: .lastTextBaseline, spacing: 12) {
                Text(viewModel.coin.displayPrice)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(viewModel.coin.changeColor)
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Text(viewModel.coin.change.contains("-") ? "▼\(viewModel.coin.absChange)%" : "▲\(viewModel.coin.absChange)%")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.coin.change.contains("-") ? .red : .green)
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            }
        }
    }
    
    private var performanceChart: some View {
        VStack {
            // Timeframe Picker
            Picker("Timeframe", selection: $viewModel.selectedTimeframe) {
                ForEach(TimeFrame.allCases, id: \.self) { timeframe in
                    Text(timeframe.title)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(viewModel.selectedTimeframe == timeframe ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundColor(viewModel.selectedTimeframe == timeframe ? .white : .primary)
                        .cornerRadius(8)
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                }
            }
            .pickerStyle(.segmented)
            
            // Chart
            chartView
        }
    }
    
    private var chartView: some View {
        ZStack {
            if viewModel.history.isEmpty {
                ProgressView()
            } else {
                Chart {
                    ForEach(viewModel.history, id: \.timestamp) { data in
                        if let price = Double(data.price) {
                            LineMark(
                                x: .value(viewModel.selectedTimeframe.xAxisTitle, Date(timeIntervalSince1970: Double(data.timestamp))),
                                y: .value(viewModel.selectedTimeframe.yAxisTitle, price)
                            )
                            .foregroundStyle(viewModel.coin.changeColor)
                            
                            AreaMark(
                                x: .value(viewModel.selectedTimeframe.xAxisTitle, Date(timeIntervalSince1970: Double(data.timestamp))),
                                y: .value(viewModel.selectedTimeframe.yAxisTitle, price)
                            )
                            .foregroundStyle(LinearGradient(
                                gradient: Gradient(colors: [
                                    viewModel.coin.changeColor.opacity(0.6),
                                    viewModel.coin.changeColor.opacity(0.2)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                        }
                    }
                    .interpolationMethod(.cardinal)
                }
                .padding(.top, 20)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            }
        }
        .frame(height: screenHeight*0.3)
    }
    
    private var statisticsSection: some View {
        VStack(spacing: 10) {
            Text("Statistics")
                .font(.body)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            
            Divider()
                .padding(.bottom, 10)
            
            HStack(spacing: 10) {
                statBlock(title: "Market Cap", value: "\(viewModel.coinDetail?.displayMarketCap ?? "")")
                statBlock(title: "24h Volume", value: "\(viewModel.coinDetail?.displayVolume24h ?? "")")
            }
            
            HStack(spacing: 10) {
                statBlock(title: "Circulating Supply", value: "\(viewModel.coinDetail?.supply.displayCirculatingSupply ?? "")")
                statBlock(title: "All-Time High", value: "\(viewModel.coinDetail?.allTimeHigh.displayPrice ?? "")")
            }
        }
    }
    
    // MARK: - Additional Info
    private var additionalInfo: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About \(viewModel.coinName)")
                .font(.body)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            
            if let coin = viewModel.coinDetail {
                Text(viewModel.coinDetail?.description ?? "")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray)
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Link("Official Website", destination: coin.websiteUrl)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            }
            
            Divider()
        }
        .padding(.top, 20)
    }
    
    // MARK: - Helper View
    private func statBlock(title: String, value: String) -> some View {
        VStack {
            Text(title)
                .font(.footnote)
                .foregroundColor(.gray)
                .dynamicTypeSize(...DynamicTypeSize.medium)
                .minimumScaleFactor(0.5)
            
            Text(value)
                .font(.body)
                .dynamicTypeSize(...DynamicTypeSize.medium)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.coinCard)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow()
    }
}

#Preview {
    CoinDetailView(dataStore: .init())
}
