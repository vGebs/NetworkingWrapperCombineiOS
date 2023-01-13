//
//  File.swift
//  
//
//  Created by Vaughn on 2023-01-12.
//

import Foundation
import Combine

@available(iOS 13.0, *)
class PostService {
    private let networkWrapper = NetworkWrapperCombine()
    private let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
    
    func getPosts() -> AnyPublisher<[Post], Error> {
        let url = baseURL.appendingPathComponent("posts")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return networkWrapper.request(with: request)
    }
    
    func getPost(id: Int) -> AnyPublisher<Post, Error> {
        let url = baseURL.appendingPathComponent("posts/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return networkWrapper.request(with: request)
    }
    
    func createPost(post: Post) -> AnyPublisher<Post, Error> {
        let url = baseURL.appendingPathComponent("posts")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(post)
        return networkWrapper.request(with: request)
    }
    
    func updatePost(id: Int, post: Post) -> AnyPublisher<Post, Error> {
        let url = baseURL.appendingPathComponent("posts/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(post)
        return networkWrapper.request(with: request)
    }
    
    func deletePost(id: Int) -> AnyPublisher<Void, Error> {
        let url = baseURL.appendingPathComponent("posts/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        return networkWrapper.request(with: request)
            .map{ _ in}
            .eraseToAnyPublisher()
    }
}
