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

final class ImageService: ImageServicing {
    
    // MARK: - `Typealias` -
    
    private typealias Request = OpenAI.ImageRequest.Concrete
    
    // MARK: - `Private Properties` -
    
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    /// MARK: - `Init` -
    
    init(
        decoder: JSONDecoder,
        encoder: JSONEncoder
    ) {
        self.decoder = decoder
        self.encoder = encoder
    }
    
    // MARK: - `Public Methods` -
    
    func images(for request: OpenAI.ImageRequest) async throws -> [Image] {
        try await Request(request: request).send(decoder, encoder).data
    }
}

// MARK - `OpenAI.ImageRequest+APIRequest` -

extension OpenAI.ImageRequest {
    struct Concrete: APIRequest {
        
        // MARK: - `Type` -
        
        typealias Response = DataResponse<[Image]>
        typealias Request = OpenAI.ImageRequest
        
        // MARK: - `Public Properties` -
        
        var body: Request? { request }
        var method: APIRequestMethod { .post }
        var path: String { "/images/generations" }
        
        // MARK: - `Init` -

        let request: Request
    }
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
        try container.encode(size.stringRepresentation, forKey: .size)
        try container.encode(response.rawValue, forKey: .responseFormat)
    }
}
