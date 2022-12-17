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
    
    func images(for request: OpenAI.ImageRequest) async throws -> DataResponseModel<[ImageModel]> {
        return DataResponse(created: 0, data: [Image(url: "https://google.com")])
    }
    
    func completions(for request: OpenAI.CompletionRequest) async throws -> CompletionModel {
        let completion = CompletionModel(id: "", object: "", created: 0, choices: [])
        return completion
    }
}
