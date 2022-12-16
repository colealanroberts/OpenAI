//
//  ImageService.swift
//  
//
//  Created by Cole Roberts on 12/6/22.
//

import Combine
import Foundation

// MARK: - `ImageServicing` -

protocol ImageServicing {
    func images(for request: OpenAI.ImageRequest) async throws -> DataResponse<[Image]>
}

// MARK: - `ImageService` -

final class ImageService: RequestService, ImageServicing {
    
    /// MARK: - `Init` -
    
    override init(
        decoder: JSONDecoder,
        encoder: JSONEncoder
    ) {
        super.init(decoder: decoder, encoder: encoder)
    }
    
    // MARK: - `Public Methods` -
    
    func images(for request: OpenAI.ImageRequest) async throws -> DataResponse<[Image]> {
        try await super.request(for: request)
    }
}

// MARK: - `OpenAI.ImageRequest+Requestable` -

extension OpenAI.ImageRequest: Requestable {
    typealias ResponseModel = DataResponse<[Image]>
    static var path: String { "/images/generations" }
    static var method: APIRequestMethod { .post }
}

// MARK: - `OpenAI.ImageRequest+Encodable` -

extension OpenAI.ImageRequest: Encodable {
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
