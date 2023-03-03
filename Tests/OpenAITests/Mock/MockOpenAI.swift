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
    
    func chats(for model: OpenAI.ChatRequest) async throws -> ChatModel {
        ChatModel(
            id: "",
            object: "",
            created: 0,
            choices: [
                .init(
                    index: 0,
                    message: .init(
                        role: "assistant",
                        content: "The 2020 World Series was played in Globe Life Field located in Arlington, Texas, USA."),
                    finishReason: "stop"
                )
            ],
            usage: .mock()
        )
    }
    
    func completions(for model: OpenAI.CompletionRequest) async throws -> CompletionModel {
        CompletionModel(
            id: "",
            object: "",
            created: 0,
            choices: [
                .init(
                    text: "This was a test",
                    index: 0
                )
            ],
            usage: .mock()
        )
    }
    
    func images(for model: OpenAI.ImageRequest) async throws -> ImagesModel {
        ImagesModel(
            created: 0,
            data: [
                .init(url: "https://google.com")
            ]
        )
    }
}

// MARK: - `MockOpenAI+FakeUsage` -

extension UsageModel {
    static func mock() -> Self {
        .init(promptTokens: 0, completionTokens: 0, totalTokens: 0)
    }
}
