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
    func images(for request: OpenAI.ImageRequest) async throws -> [Image]
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
    
    func images(for request: OpenAI.ImageRequest) async throws -> [Image] {
        try await super.request(for: request).data
    }
}

// MARK: - `OpenAI.ImageRequest+Requestable` -

extension OpenAI.ImageRequest: Requestable {
    typealias Model = DataResponse<[Image]>
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
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(prompt, forKey: .prompt)
        try container.encode(numberOfImages, forKey: .n)
        try container.encodeIfPresent(size?.stringRepresentation, forKey: .size)
        try container.encodeIfPresent(response?.rawValue, forKey: .responseFormat)
    }
}
