//
//  View+Extension.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//
import SwiftUI

extension View {
    func shadow(color: Color = Color.black.opacity(0.07), x: CGFloat = -1, y: CGFloat = 1, radius: CGFloat = 10) -> some View {
        shadow(color: color, radius: radius, x: x, y: y)
    }
    
    /// Conditionally applies a modifier to a view
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

func runAfter(_ delay: Double = 2.0, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
        action()
    }
}

func runOnMainThreadAfter(_ delay: Double = 2.0, action: @escaping () -> Void) {
    runAfter(delay) {
        runOnMainThread(action: action)
    }
}

func runOnMainThread(action: @escaping () -> Void) {
    DispatchQueue.main.async {
        action()
    }
}

func runOnBackground(
    qos: DispatchQoS.QoSClass = .userInitiated,
    action: @escaping () -> Void
) {
    DispatchQueue.global(qos: qos).async {
        action()
    }
}
