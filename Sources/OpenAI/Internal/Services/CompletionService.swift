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
        case model
        case prompt
        case suffix
        case maxTokens
        case temperature
        case topP
        case n
        case stream
        case logprobs
        case echo
        case stop
        case presencePenalty
        case frequencyPenalty
        case bestOf
        case logitBias
        case user
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(model.stringRepresentation, forKey: .model)
        try container.encode(prompt, forKey: .prompt)
        try container.encodeIfPresent(suffix, forKey: .suffix)
        try container.encodeIfPresent(maxTokens, forKey: .maxTokens)
        try container.encodeIfPresent(temperature, forKey: .temperature)
        try container.encodeIfPresent(topP, forKey: .topP)
        try container.encodeIfPresent(n, forKey: .n)
        try container.encodeIfPresent(stream, forKey: .stream)
        try container.encodeIfPresent(logprobs, forKey: .logprobs)
        try container.encodeIfPresent(echo, forKey: .echo)
        try container.encodeIfPresent(stop, forKey: .stop)
        try container.encodeIfPresent(presencePenalty, forKey: .presencePenalty)
        try container.encodeIfPresent(frequencyPenalty, forKey: .frequencyPenalty)
        try container.encodeIfPresent(bestOf, forKey: .bestOf)
        try container.encodeIfPresent(user, forKey: .user)
    }
}
