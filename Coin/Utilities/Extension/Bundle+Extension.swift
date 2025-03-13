//
//  Bundle+Extension.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import Foundation

extension Bundle {
    
    func value<T>(for key: String) -> T? {
        object(forInfoDictionaryKey: key) as? T
    }
    
    var coinApiKey: String {
        return value(for: "Coin_Api_Key") ?? ""
    }
}
