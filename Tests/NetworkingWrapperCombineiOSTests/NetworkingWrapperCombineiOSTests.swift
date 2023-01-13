import XCTest
@testable import NetworkingWrapperCombineiOS

import Combine

@available(iOS 13.0, *)
class NetworkWrapperCombineTests: XCTestCase {
    let networkWrapper = NetworkWrapperCombine()
    let usersUrl = URL(string: "https://jsonplaceholder.typicode.com/users")!
    
    func testRequestData() {
        let expectation = self.expectation(description: "Request data")
        
        networkWrapper.request(with: URLRequest(url: usersUrl))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }, receiveValue: { data in
                XCTAssert(data.count > 0)
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRequestDecodable() {
        let expectation = self.expectation(description: "Request decodable")
        
        networkWrapper.request(with: URLRequest(url: usersUrl))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }, receiveValue: { users in
                XCTAssert(users.count > 0)
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    private var cancellables = Set<AnyCancellable>()
}

