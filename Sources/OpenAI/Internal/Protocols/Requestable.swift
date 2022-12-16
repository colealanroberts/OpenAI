//
//  Requestable.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK - `Requestable` -

protocol Requestable<Model>: Encodable {
    associatedtype Model: Decodable
    
    static var method: APIRequestMethod { get }
    static var path: String { get }
}
