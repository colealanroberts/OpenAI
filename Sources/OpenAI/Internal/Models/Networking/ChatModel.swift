//
//  ChatModel.swift
//  
//
//  Created by Cole Roberts on 3/3/23.
//

import Foundation

// MARK: - `ChatModel` -

public struct ChatModel: Decodable {
    public let id: String
    public let object: String
    public let created: Int
    public let choices: [Choice]
    public let usage: UsageModel
}

// MARK: - `ChatModel+Choice` -

public extension ChatModel {
    struct Choice: Decodable {
        public let index: Int
        public let message: Message
        public let finishReason: String
    }
}

// MARK: - `ChatModel+Choice.Message` -

public extension ChatModel.Choice {
    struct Message: Decodable {
        public let role: String
        public let content: String
    }
}
