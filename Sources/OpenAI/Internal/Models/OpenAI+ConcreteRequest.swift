//
//  OpenAI+ConcreteRequest.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK: - `OpenAI+Concrete` -

extension OpenAI {
    struct ConcreteRequest<Request: Requestable, Response>: APIRequest {
        
        // MARK: - `Public Properties` -

        var body: Request? { request }
        var method: APIRequestMethod { Request.method }
        var path: String { Request.path }
        
        // MARK: - `Init` -
        
        let credentials: OpenAI.Credentials
        let request: Request
    }
}
