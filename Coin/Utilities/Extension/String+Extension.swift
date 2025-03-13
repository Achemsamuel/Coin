//
//  String+Extension.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//

import Foundation

extension String {
    var commasRemoved: String { replacingOccurrences(of: ",", with: "") }
    
    var withoutAnySpecialCharacters: String {
        self.components(separatedBy: CharacterSet.symbols).joined()
    }
    
    var currencyStripped: String {
        return self.withoutAnySpecialCharacters.commasRemoved
    }
    
    func currencyFormatted(symbol: String, decimalPlaces: Int = 0) -> String {
        let value = self.currencyStripped
        if let doubleValue = Double(value) {
            
            let currencyFormatter = NumberFormatter()
            currencyFormatter.groupingSeparator = ","
            currencyFormatter.groupingSize = 3
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .none
            currencyFormatter.locale = Locale(identifier: "en_US_POSIX")
            currencyFormatter.minimumFractionDigits = decimalPlaces
            currencyFormatter.maximumFractionDigits = decimalPlaces
            
            if doubleValue < 1 {
                currencyFormatter.minimumFractionDigits = decimalPlaces+2
                currencyFormatter.maximumFractionDigits = decimalPlaces+2
                return "\(symbol)\(currencyFormatter.string(from: doubleValue as NSNumber) ?? "")"
            } else {
                return "\(symbol)\(currencyFormatter.string(from: doubleValue as NSNumber) ?? "")"
            }
        } else {
            return self
        }
    }
    
    var url: URL? {
        URL(string: self)
    }
}
