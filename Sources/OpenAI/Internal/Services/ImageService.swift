//
//  ImageService.swift
//  
//
//  Created by Cole Roberts on 12/6/22.
//

import Combine
import Foundation

// MARK: - `ImageServicing` -

protocol ImageServicing {
    func images(for request: OpenAI.ImageRequest) async throws -> [Image]
}

// MARK: - `ImageService` -

final class ImageService: ImageServicing {
    
    // MARK: - `Typealias` -
    
    typealias Request = OpenAI.ImageRequest.Concrete
    
    // MARK: - `Private Properties` -
    
    private let decoder: JSONDecoder
    private var subscriptions: Set<AnyCancellable>
    
    /// MARK: - `Init` -
    
    init() {
        self.decoder = .init()
        self.subscriptions = .init()
    }
    
    // MARK: - `Public Methods` -
    
    func images(for request: OpenAI.ImageRequest) async throws -> [Image] {
        try await Request(request).send(decoder)
    }
}

// MARK - `OpenAI.ImageRequest+APIRequest` -

extension OpenAI.ImageRequest {
    struct Concrete: APIRequest {
        
        // MARK: - `Type` -
        
        typealias Response = [Image]
        
        // MARK: - `Public Properties` -
        
        var method: APIRequestMethod { .post }
        var path: String { "/images/generations" }
        
        var headers: [APIRequest.Header]? {
            guard let credentials = OpenAI.shared.credentials else { return nil }
            var headers: [Header] = [
                ("Content-Type", "application/json"),
                ("Authorization", "Bearer \(credentials.token)")
            ]
            
            if let organization = credentials.organization {
                headers.append(("OpenAI-Organization", organization))
            }
            
            return headers
        }
        
        var body: [String : Any] {
            [
                "prompt": prompt,
                "n": n,
                "size": size.toPixel()
            ]
        }
        
        // MARK: - `Private Properties` -
        
        private let prompt: String
        private let n: Int
        private let size: OpenAI.ImageRequest.Size
        
        // MARK: - `Init` -
        
        init(
            _ request: OpenAI.ImageRequest
        ) {
            self.prompt = request.prompt
            self.n = request.numberOfImages
            self.size = request.size
        }
    }
}
