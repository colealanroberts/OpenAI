//
//  OpenAI+ImageRequest+Requestable.swift
//  
//
//  Created by Cole Roberts on 12/16/22.
//

import Foundation

// MARK: - `OpenAI.ImageRequest+Requestable` -

extension OpenAI.ImageRequest: Requestable {
    typealias ResponseModel = ImagesModel
    static var path: String { "/images/generations" }
    static var method: APIRequestMethod { .post }
    
    private enum CodingKeys: String, CodingKey {
        case prompt
        case n
        case size
        case responseFormat
        case user
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(prompt, forKey: .prompt)
        try container.encodeIfPresent(numberOfImages, forKey: .n)
        try container.encodeIfPresent(size?.stringRepresentation, forKey: .size)
        try container.encodeIfPresent(response?.rawValue, forKey: .responseFormat)
        try container.encodeIfPresent(user, forKey: .user)
    }
}
