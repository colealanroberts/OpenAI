//
//  RequestService.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

class RequestService {
    
    // MARK: - `Private Properties` -
    
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    // MARK: - `Init` -
    
    init(
        decoder: JSONDecoder,
        encoder: JSONEncoder
    ) {
        self.decoder = decoder
        self.encoder = encoder
    }
    
    func request<T: Requestable>(for request: T) async throws -> T.Model {
        try await OpenAI.Concrete(request: request).send(decoder, encoder)
    }
}
