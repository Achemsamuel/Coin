import SwiftUI

struct CoinListItemView: View {
    private let coin: Coin?
    
    init(coin: Coin?) {
        self.coin = coin
    }
    
    var body: some View {
        if let coin = coin {
            HStack(spacing: 15) {
                RemoteImage(url: coin.iconUrl, height: 40, width: 40, placeHolder: AnyView(Image(.placeholder)))
                    .clipShape(Circle())
                    .id(coin.iconUrl)

                VStack(alignment: .leading, spacing: 3) {
                    Text(coin.symbol)
                        .font(.caption)
                        .fontWeight(.bold)
                        .layoutPriority(1)
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)

                    Text(coin.name)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .layoutPriority(1)
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 3) {
                    PriceView(price: coin.displayPrice)
                    ChangeView(change: coin.change, changeColor: coin.changeColor)
                }
            }
            .padding()
            .background(.coinCard)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow()
            .padding(.horizontal, 15)
            .padding(.bottom, 8)
            .padding(.top, 8)
            .transition(.scale)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.4)) {}
            }
        }
    }
}

// MARK: - Price View
private struct PriceView: View {
    let price: String
    
    var body: some View {
        Text(price)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundStyle(.primary)
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
}

// MARK: - Change View
private struct ChangeView: View {
    let change: String
    let changeColor: Color
    
    var body: some View {
        Text(change)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 2)
            .background(changeColor)
            .clipShape(RoundedRectangle(cornerRadius: 3))
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
}

// MARK: - Preview
#Preview {
    CoinListItemView(coin: Coin(uuid: "", symbol: "BTC", name: "Bitcoin", color: "", iconUrl: URL(string: "https://cdn.coinranking.com/Sy33Krudb/btc.svg")!, marketCap: "", price: "20,000", listedAt: 0, change: "-1.0", rank: 2, lowVolume: false, coinrankingUrl: "", volume24h: "", btcPrice: "", isFavorite: false))
}
