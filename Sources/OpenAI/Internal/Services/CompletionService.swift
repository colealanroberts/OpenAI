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

final class CompletionService: RequestService, CompletionServicing {
    
    // MARK: - `Init` -
    
    override init(
        decoder: JSONDecoder,
        encoder: JSONEncoder
    ) {
        super.init(decoder: decoder, encoder: encoder)
    }
    
    // MARK: - `Public Methods` -
    
    func completions(for request: OpenAI.CompletionRequest) async throws -> Completion {
        try await super.request(for: request)
    }
}

// MARK: - `OpenAI.CompletionRequest+Requestable` -

extension OpenAI.CompletionRequest: Requestable {
    typealias Model = Completion
    static var path: String { "/completions" }
    static var method: APIRequestMethod { .post }
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
