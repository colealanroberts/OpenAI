//
//  ChatModel.swift
//  
//
//  Created by Cole Roberts on 3/3/23.
//

import Foundation

// MARK: - `ChatModel` -

public struct ChatModel: Decodable {
    let id: String
    let object: String
    let created: Int
    let choices: [Choice]
    let usage: UsageModel
}

// MARK: - `ChatModel+Choice` -

public extension ChatModel {
    struct Choice: Decodable {
        let index: Int
        let message: Message
        let finishReason: String
    }
}

// MARK: - `ChatModel+Choice.Message` -

public extension ChatModel.Choice {
    struct Message: Decodable {
        let role: String
        let content: String
    }
}
