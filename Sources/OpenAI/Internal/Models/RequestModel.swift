//
//  RequestModel.swift
//  
//
//  Created by Cole Roberts on 12/6/22.
//

import Foundation

// MARK: - `RequestModel` -

struct RequestModel<T: Decodable>: Decodable {
    let created: Int
    let data: T
}

// MARK: - `Typealias` -

typealias Request = RequestModel
