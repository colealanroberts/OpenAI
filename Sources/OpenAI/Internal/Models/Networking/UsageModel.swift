//
//  UsageModel.swift
//  
//
//  Created by Cole Roberts on 3/3/23.
//

import Foundation

// MARK: - `UsageModel` -

public struct UsageModel: Decodable {
    public let promptTokens: Int
    public let completionTokens: Int
    public let totalTokens: Int
}
