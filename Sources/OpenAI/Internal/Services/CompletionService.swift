//
//  CompletionService.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK: - `CompletionServicing` -

protocol CompletionServicing {
    func completions(for request: OpenAI.CompletionRequest) async throws -> Completion
}

// MARK: - `CompletionService` -

final class CompletionService: CompletionServicing {
    
    // MARK: - `Typealias` -
    
    private typealias Request = OpenAI.CompletionRequest.Concrete
    
    // MARK: - `Private Properties` -
    
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    // MARK: - `Init` -
    
    init(
        decoder: JSONDecoder,
        encoder: JSONEncoder
    ) {
        self.decoder = decoder
        self.encoder = encoder
    }
    
    // MARK: - `Public Methods` -
    
    func completions(for request: OpenAI.CompletionRequest) async throws -> Completion {
        try await Request(request: request).send(decoder, encoder)
    }
}

// MARK - `OpenAI.ImageRequest+CompletionRequest` -

extension OpenAI.CompletionRequest {
    struct Concrete: APIRequest {
        
        // MARKL - `Type` -
        
        typealias Response = Completion
        typealias Request = OpenAI.CompletionRequest
        
        // MARK: - `Public Properties` -

        var body: Request? { request }
        var method: APIRequestMethod { .post }
        var path: String { "/completions" }
        
        // MARK: - `Init` -
        
        let request: Request
    }
}

// MARK: - `OpenAI.CompletionRequest+Encodable` -

extension OpenAI.CompletionRequest: Encodable {
    private enum CodingKeys: String, CodingKey {
        case maxTokens
        case model
        case prompt
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(maxTokens, forKey: .maxTokens)
        try container.encode(model.stringRepresentation, forKey: .model)
        try container.encode(prompt, forKey: .prompt)
    }
}
