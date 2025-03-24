//
//  PriceView.swift
//  Coin
//
//  Created by Achem Samuel on 3/24/25.
//
import SwiftUI

struct PriceView: View {
    let price: String
    
    var body: some View {
        Text(price)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundStyle(.primary)
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
}

struct ChangeView: View {
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
