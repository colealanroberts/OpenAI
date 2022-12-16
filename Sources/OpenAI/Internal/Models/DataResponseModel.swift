//
//  DataResponseModel.swift
//  
//
//  Created by Cole Roberts on 12/6/22.
//

import Foundation

// MARK: - `RequestModel` -

struct DataResponseModel<T: Decodable>: Decodable {
    let created: Int
    let data: T
}

// MARK: - `Typealias` -

typealias DataResponse = DataResponseModel
