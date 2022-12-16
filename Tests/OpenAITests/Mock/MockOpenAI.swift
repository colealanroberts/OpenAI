//
//  MockOpenAI.swift
//  
//
//  Created by Cole Roberts on 12/6/22.
//

import Combine
@testable import OpenAI

final class MockOpenAI: OpenAISDK {
    func connect(with credentials: OpenAI.Credentials) -> Self {
        return self
    }
    
    func images(for request: OpenAI.ImageRequest) async throws -> [Image] {
        let image = Image(url: .init(string: "https://google.com")!)
        return [image]
    }
    
    func completions(for request: OpenAI.CompletionRequest) async throws -> Completion {
        let completion = Completion(id: "", object: "", created: 0, choices: [])
        return completion
    }
}
