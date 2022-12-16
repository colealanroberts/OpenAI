//
//  CompletionModel.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK: - `CompletionModel` -

public struct CompletionModel {
    let id: String
    let object: String
    let created: Int
    let choices: [Choice]
}

// MARK: - `CompletionModel+Choice`

public extension CompletionModel {
    struct Choice {
        let text: String
        let index: Int
    }
}

// MARK: - `CompletionModel+Decodable` -

extension CompletionModel: Decodable {}
extension CompletionModel.Choice: Decodable {}

// MARK: - `Typealias` -

public typealias Completion = CompletionModel
