//
//  UsageModel.swift
//  
//
//  Created by Cole Roberts on 3/3/23.
//

import Foundation

// MARK: - `UsageModel` -

struct UsageModel: Decodable {
    let promptTokens: Int
    let completionTokens: Int
    let totalTokens: Int
}
