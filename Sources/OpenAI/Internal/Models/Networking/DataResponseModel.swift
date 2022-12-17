//
//  DataResponseModel.swift
//  
//
//  Created by Cole Roberts on 12/6/22.
//

import Foundation

// MARK: - `DataResponseModel` -

public struct DataResponseModel<T: Decodable>: Decodable {
    public let created: Int
    public let data: T
}

// MARK: - `Typealias` -

public typealias DataResponse = DataResponseModel
