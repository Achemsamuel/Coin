//
//  UserDefault+Extension.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import Foundation

extension UserDefaults {
    enum Keys: String {
        case favorites
    }
    
    var favorites: [String] {
        get {
            guard let data = data(forKey: UserDefaults.Keys.favorites.rawValue) else {
                return []
            }
            let value = try? JSONDecoder().decode([String].self, from: data)
            return value ?? []
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            set(data, forKey: UserDefaults.Keys.favorites.rawValue)
        }
    }
}
