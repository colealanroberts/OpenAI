//
//  OpenAI+ConcreteRequest.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK: - `OpenAI+Concrete` -

extension OpenAI {
    struct ConcreteRequest<T: Requestable, U>: APIRequest {
        typealias Request = T
        typealias Response = U
        
        // MARK: - `Public Properties` -

        var body: Request? { request }
        var method: APIRequestMethod { T.method }
        var path: String { T.path }
        
        // MARK: - `Init` -
        
        let request: Request
    }
}
