//
//  CoinFavoritesView.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import SwiftUI

struct CoinFavoritesView: View {
    @ObservedObject var dataStore: CoinsDataLocalRepository
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ZStack {
            if dataStore.favoriteCoins.isEmpty {
                VStack {
                    Spacer()
                    Text("You haven't added any favorites yet!".localized)
                        .font(.body)
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    Spacer()
                }
            } else {
                VStack(spacing: 10) {
                    CoinTableView(path: $navigationPath, coins: Array(dataStore.favoriteCoins), localRepo: dataStore)
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            dataStore.prepareFavoriteCoins()
        }
    }
}

#Preview {
    CoinFavoritesView(dataStore: .init(), navigationPath: .constant(.init()))
}
