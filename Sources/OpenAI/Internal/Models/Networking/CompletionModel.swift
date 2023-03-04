//
//  CompletionModel.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK: - `CompletionModel` -

public struct CompletionModel: Decodable {
    public let id: String
    public let object: String
    public let created: Int
    public let choices: [Choice]
    public let usage: UsageModel
}

// MARK: - `CompletionModel+Choice`

public extension CompletionModel {
    struct Choice: Decodable {
        public let text: String
        public let index: Int
    }
}
