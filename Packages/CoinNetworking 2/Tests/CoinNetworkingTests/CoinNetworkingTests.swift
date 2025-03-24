import XCTest
@testable import CoinNetworking
import Foundation


@available(iOS 13.0, *)
final class CoinNetworkingServiceTests: XCTestCase {
    
    var service: CoinNetworkingService!
    
    override func setUp() {
        super.setUp()
        service = CoinNetworkingService()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
}
