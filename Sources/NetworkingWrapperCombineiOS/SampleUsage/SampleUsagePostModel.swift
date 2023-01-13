//
//  File.swift
//  
//
//  Created by Vaughn on 2023-01-12.
//

import Foundation

struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
