## NetworkWrapperCombineiOS

`NetworkWrapperCombineiOS` is a networking library written in Swift using the `Combine` framework that utlilizes the `dataTaskPublisher` from `URLSession`. It provides a simple, easy-to-use interface for making network requests and handling responses.

## Features

- Supports GET, POST, PUT, PATCH and DELETE HTTP methods
- Automatically handles JSON decoding and encoding
- Provides a convenient way to handle errors
- Allows for setting timeout
- Provides a way to cancel ongoing requests
- Accepts URLRequest as input

##Availability

Works with iOS 13+

## Installation 

### Swift Package Manager

You can install `NetworkWrapperCombineiOS` using the [Swift Package Manager](https://swift.org/package-manager/).

1. In Xcode, open your project and navigate to File > Swift Packages > Add Package Dependency.
2. Enter the repository URL `https://github.com/vGebs/NetworkingWrapperCombineiOS.git` and click Next.
3. Select the version you want to install, or leave the default version and click Next.
4. In the "Add to Target" section, select the target(s) you want to use `NetworkWrapperiOS` in and click Finish.

## Usage

To use `NetworkWrapperCombineiOS`, you first need to create an instance of the NetworkWrapper class.

```swift
import NetworkWrapperCombineiOS
let networkWrapper = NetworkWrapperCombine(timeout: 20)
```

You can then use the `request(with:)` method to make a request. This method returns a Publisher that you can subscribe to.

```swift
let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
var request = URLRequest(url: url)
request.httpMethod = "GET"

let cancellable = networkWrapper.request(with: request)
    .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            print(error)
        case .finished:
            break
        }
    }, receiveValue: { posts in
        print(posts)
    })
```

You can cancel a request by calling the cancel() method on the returned AnyCancellable object.

```swift
cancellable.cancel()
```

You can also set the timeout of the requests (in seconds, set to 15 by default)

```swift
let networkWrapper = NetworkWrapperCombine(timeout: 20)
networkWrapper.timeout = 10
```

## Error Handling

`NetworkWrapperCombineiOS` provides a convenient way to handle errors. It uses a custom `NetworkError` enum that has cases for different types of errors that can occur during a network request.

```swift
public enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decodingError
    case unexpectedError(Error)
}
```
You can use a switch statement to handle different cases of the error in the completion block of the sink method.
```swift
let cancellable = networkWrapper.request(with: request)
    .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            switch error {
            case .invalidURL:
                // Handle invalid URL error
            case .invalidResponse:
                // Handle invalid response error
            case .statusCode(let code):
                // Handle specific status code error
            case .decodingError:
                // Handle JSON decoding error
            case .unexpectedError(let error):
                // Handle unexpected error
            }
        case .finished:
            break
        }
    }, receiveValue: { posts in
        print(posts)
    })
```

## License

`NetworkWrapperCombineiOS` is released under the MIT license. See LICENSE for details.

## Contribution

We welcome contributions to NetworkWrapper. If you have a bug fix or a new feature, please open a pull request.
