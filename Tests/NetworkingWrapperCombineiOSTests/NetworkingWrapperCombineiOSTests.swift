import XCTest
@testable import NetworkingWrapperCombineiOS

import Combine

@available(iOS 13.0, *)
class NetworkWrapperTests: XCTestCase {
    var networkWrapper: NetworkWrapperCombine!

    override func setUp() {
        networkWrapper = NetworkWrapperCombine(timeout: 10)
    }

    private var cancellables: [AnyCancellable] = []
    
    func testGetRequest() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let request = URLRequest(url: url)
        let expectation = XCTestExpectation(description: "GET request should succeed")

        networkWrapper.request(with: request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { posts in
                XCTAssert(!posts.isEmpty)
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
}

