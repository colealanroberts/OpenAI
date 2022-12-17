//
//  OpenAI.CompletionRequest+Requestable.swift
//  
//
//  Created by Cole Roberts on 12/16/22.
//

import Foundation

// MARK: - `OpenAI.CompletionRequest+Requestable` -

extension OpenAI.CompletionRequest: Requestable {
    typealias ResponseModel = CompletionModel
    static var path: String { "/completions" }
    static var method: APIRequestMethod { .post }
    
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
