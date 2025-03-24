//
//  CoinError.swift
//  CoinNetworking
//
//  Created by Achem Samuel on 3/12/25.
//

import Foundation

public enum CoinError: Error, CustomStringConvertible {
    
    case badRequestData
    case badUrl
    case endpointError(message: String)
    case emptyResponseData
    case unDecodableResponse
    case unknownError
    case successfulButCouldNotDecode
    case tryAgain
    case unauthorized
    case errorWithCode(message: String, statusCode: StatusCodes)
    
    public var description: String {
        switch self {
        case .badRequestData:
            return "Sorry, we couldn't make that happen. Please, try again."
        case .badUrl:
            return "Incorrect destination"
        case let .endpointError(message):
            return message
        case .emptyResponseData:
            return "Sorry, we couldn't make that happen. Please, try again."
        case .unDecodableResponse:
            return "The response could not be decoded"
        case .unknownError:
            return "Your request wasn't completed. Please, try again."
        case .successfulButCouldNotDecode:
            return "Successful"
        case .tryAgain:
            return "Sorry, we couldn't make that happen. Please, try again."
        case .unauthorized:
            return "You are not authorized to complete this action"
        case let .errorWithCode(message, _):
            return message
        }
    }
}

public enum StatusCodes: Int, Sendable {
    case serverError = 500
    case server = 502
    case unauthorized = 400
    case forbidden = 403
    
    var error: CoinError {
        switch self {
        case .serverError, .server:
            return .errorWithCode(message: "Sorry, we couldn't make that happen. Please, try again.", statusCode: self)
        case .unauthorized:
            return .errorWithCode(message: "Your request wasn't completed. Please, try again.", statusCode: self)
        case .forbidden:
            return .errorWithCode(message: "Your request wasn't completed. Please, try again.", statusCode: self)
        }
    }
}

extension CoinError: LocalizedError {
    public var errorDescription: String? {
        description
    }
}

public enum ResponseError: Error {
    case ErrorResponse(String)
}

extension ResponseError: LocalizedError {
    ///returns a presentable error
    public var error: String {
        switch self {
        case .ErrorResponse(let error):
            return error
    }
  }
}

enum ErrorMessages: String {
    case internet = "Your internet connection might be offline. Please, check and try again."
    case timeout = "Sorry, we couldn't make that happen. Please try again."
}
