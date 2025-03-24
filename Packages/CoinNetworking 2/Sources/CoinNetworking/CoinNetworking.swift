// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

@available(iOS 13.0.0, *)
open class CoinNetworkingService: NSObject, @unchecked Sendable {
    
    public static let shared = CoinNetworkingService()
    
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 120
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        session = URLSession(configuration: config, delegate: self, delegateQueue: .main)
        
        return session
    }()
    
    public override init() {}
    
    public func addHeaders(_ parameter: Parameters) {
        session.configuration.httpAdditionalHeaders = parameter
    }
    
    public func makeRequest<T: Decodable>(url: URL?,
                                          parameters: Parameters = [:],
                                          method: HTTPMethod,
                                          returning objectType: T.Type) async throws -> T? {
        
        if !Reachability.isConnectedToNetwork() {
            throw CoinError.endpointError(message: ErrorMessages.internet.rawValue)
        }
        
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            if !parameters.isEmpty {
                let body = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = body
            }
            
            do {
                let (data, response) = try await session.data(for: request)
                let fetchedData = try JSONDecoder().decode(objectType.self, from: mapResponse(response: (data, response)))
                return fetchedData
            } catch {
                print(error.localizedDescription)
                throw CoinError.unDecodableResponse
            }
            
        } else {
            throw CoinError.badUrl
        }
    }
    
    private func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return response.data
        case 400:
            throw CoinError.badRequestData
        case 401:
            throw CoinError.unauthorized
        case 402:
            throw CoinError.unknownError
        case 403:
            throw CoinError.unauthorized
        case 404:
            throw CoinError.emptyResponseData
        case 413:
            throw CoinError.unknownError
        case 422:
            throw CoinError.unknownError
        default:
            throw CoinError.tryAgain
        }
    }
}

@available(iOS 13.0.0, *)
extension CoinNetworkingService: URLSessionDelegate {
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        //Trust the certificate even if not valid
        let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        
        completionHandler(.useCredential, urlCredential)
    }
}
