//
//  MockOpenAI.swift
//  
//
//  Created by Cole Roberts on 12/6/22.
//

import Combine
@testable import OpenAI

final class MockOpenAI: OpenAISDK {
    func images(for request: OpenAI.ImageRequest) async throws -> [Image] {
        let image = Image(url: .init(string: "https://google.com")!)
        return [image]
    }
}
