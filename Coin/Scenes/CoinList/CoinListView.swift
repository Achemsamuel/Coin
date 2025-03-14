//
//  CoinListView.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import SwiftUI

struct CoinListView: View {
    @StateObject private var viewModel: ViewModel
    @State private var navigationPath: NavigationPath = .init()
    
    init(dataStore: CoinsDataLocalRepository) {
        _viewModel = StateObject(wrappedValue: .init(dataStore: dataStore))
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                if viewModel.dataStore.coins.isEmpty {
                    emptyState
                } else {
                    coinsList
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    filterView
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    favoritesView
                }
            }
            .navigationTitle("Coins")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: NavigationItem.self) { item in
                ViewFactory.destination(for: item, datastore: viewModel.dataStore, path: $navigationPath)
            }
        }
        .background(.coinBackground)
        .if(!viewModel.dataStore.coins.isEmpty) { view in
            view.searchable(text: $viewModel.searchQuery, placement: .automatic, prompt: Text("Search by name or symbol..."))
        }
        .onAppear {
            viewModel.prefetchCoins()
        }
    }
    
    private var favoritesView: some View {
        Button {
            navigationPath.append(NavigationItem.favorites)
        } label: {
            Image(systemName: "star.fill")
                .foregroundStyle(.accent)
        }
    }
    
    private var filterView: some View {
        Menu {
            ForEach(SortOption.allCases, id: \.self) { option in
                Button {
                    viewModel.sortOption = option
                } label: {
                    HStack(spacing: 10) {
                        Text(option.title)
                            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                        if viewModel.sortOption == option {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "arrow.up.and.down.text.horizontal")
                .foregroundStyle(.accent)
        }
    }
    
    private var emptyState: some View {
        VStack {
            ProgressView()
            Text("Loading" + String(repeating: ".", count: viewModel.dotCount))
                .font(.body)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                .onReceive(viewModel.timer) { _ in
                    if viewModel.showLoader {
                        viewModel.dotCount = (viewModel.dotCount + 1) % (viewModel.maxDots + 1)
                    }
                }
        }
    }
    
    private var coinsList: some View {
        VStack(spacing: 10) {
            CoinTableView(path: $navigationPath, coins: viewModel.filteredList, localRepo: viewModel.dataStore) { coin in
                viewModel.verifyCoinPosition(via: coin)
            }
            
            if viewModel.isLoadingMoreCoins {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .padding(.bottom, 40)
            } else {
                EmptyView()
                    .frame(height: 30)
            }
        }
    }
}

#Preview {
    CoinListView(dataStore: .init())
}
