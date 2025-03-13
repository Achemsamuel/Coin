//
//  LandingView.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import SwiftUI

struct LandingView: UIViewControllerRepresentable {
    var action: (() -> Void)?
    
    func makeUIViewController(context: Context) -> LandingViewController {
        let vc = LandingViewController()
        vc.action = action
        return vc
    }

    func updateUIViewController(_ uiViewController: LandingViewController, context: Context) {
        // No updates needed for now
    }
}
