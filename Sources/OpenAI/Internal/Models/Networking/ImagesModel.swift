//
//  ImagesModel.swift
//  
//
//  Created by Cole Roberts on 12/6/22.
//

import Foundation

// MARK: - `DataResponseModel` -

public struct ImagesModel: Decodable {
    public let created: Int
    public let data: [ImageModel]
}
