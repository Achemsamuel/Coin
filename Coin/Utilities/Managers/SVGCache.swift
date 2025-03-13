//
//  SVGCache.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//
import Foundation

final class SVGCache {
    static let shared = SVGCache()
    private var cache: [URL: Data] = [:]
    
    func get(_ url: URL) -> Data? {
        return cache[url]
    }
    
    func set(_ url: URL, data: Data) {
        cache[url] = data
    }
}
