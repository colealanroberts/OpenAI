//
//  OpenAI+ChatRequest+Requestable.swift
//  
//
//  Created by Cole Roberts on 3/3/23.
//

import Foundation

// MARK: - `OpenAI.ChatRequest+Requestable` -

extension OpenAI.ChatRequest: Requestable {
    typealias ResponseModel = ChatModel
    static var path: String { "/chat/completions"}
    static var method: APIRequestMethod { .post }
    
    private enum CodingKeys: String, CodingKey {
        case model
        case messages
        case temperature
        case topP
        case n
        case stream
        case stop
        case maxTokens
        case presencePenalty
        case frequencyPenalty
        case user
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(model.stringRepresentation, forKey: .model)
        try container.encode(messages, forKey: .messages)
        try container.encodeIfPresent(temperature, forKey: .temperature)
        try container.encodeIfPresent(topP, forKey: .topP)
        try container.encodeIfPresent(n, forKey: .n)
        try container.encodeIfPresent(stream, forKey: .stream)
        try container.encodeIfPresent(stop, forKey: .stop)
        try container.encodeIfPresent(maxTokens, forKey: .maxTokens)
        try container.encodeIfPresent(presencePenalty, forKey: .presencePenalty)
        try container.encodeIfPresent(frequencyPenalty, forKey: .frequencyPenalty)
        try container.encodeIfPresent(user, forKey: .user)
    }
}

// MARK: - `OpenAI.ChatRequest+Message+Encodable` -

extension OpenAI.ChatRequest.Message: Encodable {
    private enum CodingKeys: String, CodingKey {
        case role
        case content
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(role.rawValue, forKey: .role)
        try container.encode(content, forKey: .content)
    }
}
