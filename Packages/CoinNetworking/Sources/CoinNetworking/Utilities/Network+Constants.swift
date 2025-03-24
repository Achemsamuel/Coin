//
//  Network+Constants.swift
//  CoinNetworking
//
//  Created by Achem Samuel on 3/12/25.
//

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

extension Error {
    var isTimeout: Bool {
        let desc = localizedDescription.lowercased()
        return desc.contains("network") || desc.contains("url")
    }
}
