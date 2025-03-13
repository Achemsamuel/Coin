//
//  CoinListTableViewCell.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import UIKit
import SwiftUI

final class CoinTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: CoinTableViewCell.self)
    
    var coin: Coin? {
        didSet {
            hostingController.rootView = CoinListItemView(coin: coin)
        }
    }
    
    private var hostingController = UIHostingController(rootView: CoinListItemView(coin: nil))
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hostingController.rootView = CoinListItemView(coin: nil) 
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if let swiftUIView = hostingController.view {
            swiftUIView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(swiftUIView)
            
            NSLayoutConstraint.activate([
                swiftUIView.topAnchor.constraint(equalTo: contentView.topAnchor),
                swiftUIView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                swiftUIView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                swiftUIView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
