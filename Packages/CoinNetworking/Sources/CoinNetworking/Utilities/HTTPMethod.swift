//
//  HTTPMethod.swift
//  CoinNetworking
//
//  Created by Achem Samuel on 3/12/25.
//

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    /// `CONNECT` method.
    nonisolated(unsafe) public static let connect = HTTPMethod(rawValue: "CONNECT")
    /// `DELETE` method.
    nonisolated(unsafe) public static let delete = HTTPMethod(rawValue: "DELETE")
    /// `GET` method.
    nonisolated(unsafe) public static let get = HTTPMethod(rawValue: "GET")
    /// `HEAD` method.
    nonisolated(unsafe) public static let head = HTTPMethod(rawValue: "HEAD")
    /// `OPTIONS` method.
    nonisolated(unsafe) public static let options = HTTPMethod(rawValue: "OPTIONS")
    /// `PATCH` method.
    nonisolated(unsafe) public static let patch = HTTPMethod(rawValue: "PATCH")
    /// `POST` method.
    nonisolated(unsafe) public static let post = HTTPMethod(rawValue: "POST")
    /// `PUT` method.
    nonisolated(unsafe) public static let put = HTTPMethod(rawValue: "PUT")
    /// `QUERY` method.
    nonisolated(unsafe) public static let query = HTTPMethod(rawValue: "QUERY")
    /// `TRACE` method.
    nonisolated(unsafe) public static let trace = HTTPMethod(rawValue: "TRACE")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
