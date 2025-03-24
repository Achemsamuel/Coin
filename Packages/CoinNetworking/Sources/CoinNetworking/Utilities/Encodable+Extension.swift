//
//  Encoder+Extension.swift
//  CoinNetworking
//
//  Created by Achem Samuel on 3/12/25.
//
import Foundation

extension Encodable {
    
    var jsonString: String {
        do {
            return String(data: try JSONEncoder().encode(self), encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    
    var prettyJson: String {
        if let responseData = try? JSONSerialization.data(withJSONObject: self.dictionary, options: .prettyPrinted) {
            return String(data: responseData, encoding: .utf8) ?? ""
        }
        return ""
    }
    
    var dictionaryValue: Any {
        do {
            let data = try JSONEncoder().encode(self)
            return try JSONSerialization.jsonObject(with: data)
        } catch {
            return ""
        }
    }
    
    var dictionaryArray: [[String: Any]] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [[String: Any]] ?? [[:]]
    }
}
