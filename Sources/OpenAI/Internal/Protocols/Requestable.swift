//
//  Requestable.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK - `Requestable` -

protocol Requestable<ResponseModel>: Encodable {
    associatedtype ResponseModel: Decodable
    
    static var method: APIRequestMethod { get }
    static var path: String { get }
}
