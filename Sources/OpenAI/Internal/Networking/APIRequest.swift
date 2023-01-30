//
//  APIRequest.swift
//  
//
//  Created by Cole Roberts on 12/6/22.
//

import Foundation

// MARK: - `APIRequestMethod` -

enum APIRequestMethod: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - `APIRequestError` -

public enum APIRequestError: Error, LocalizedError {
    
    case statusCode(Int)
    case openAIError(OpenAIError)
    
    public var localizedDescription: String {
        switch self {
        case .openAIError(let msg):
            print(msg.message)
            return msg.message
        case .statusCode(let code):
            return "Status code: \(code)"
        }
    }
    
    public var errorDescription: String? { return localizedDescription }
}

struct OpenAIErrorWrapper: Error, Codable {
    /// The error object itself.
    let error: OpenAIError
}

// MARK: - `OpenAIErrorMessage` -

public struct OpenAIError: Error, Codable {
    /// The message associated with the error.
    public let message: String

    /// The type of error the object is.
    public let type: String

    /// The parameters of the error.
    public let param: String?

    /// The code associated with the error.
    public let code: String?
}

// MARK: - `APIRequest` -

protocol APIRequest {
    associatedtype Response
    associatedtype Request: Encodable
    
    typealias Header = (key: String, value: String)
    
    var headers: [Header] { get }
    var method: APIRequestMethod { get }
    var path: String { get }
    var host: String { get }
    var body: Request? { get }
    var request: URLRequest { get }
    var credentials: OpenAI.Credentials { get }
}

extension APIRequest {
    var body: Encodable? { nil }
    var scheme: String { Constants.API.scheme  }
    var host: String { Constants.API.baseURL }
    
    var headers: [Header] {
        [
            Constants.API.Headers.contentType,
            Constants.API.Headers.token(credentials.token),
            Constants.API.Headers.organization(credentials.organization)
        ].compactMap { $0 }
    }
}

extension APIRequest {
    var request: URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = Constants.API.versionPath + path
        
        guard let url = components.url else {
            preconditionFailure("The supplied url \(String(describing: components.url)) was malformed!")
        }
        
        return URLRequest(url: url)
    }
    
    fileprivate func materialize(_ encoder: JSONEncoder) -> URLRequest {
        var req = request
        req.httpMethod = method.rawValue
        
        do {
            req.httpBody = try encoder.encode(body)
        } catch {
            assertionFailure(error.localizedDescription)
        }
        
        headers.forEach {
            req.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return req
    }
}

extension APIRequest where Response: Decodable {
    func send(
        _ decoder: JSONDecoder,
        _ encoder: JSONEncoder
    ) async throws -> Response {
        let (data, response) = try await URLSession.shared.data(for: materialize(encoder))
        guard let response = response as? HTTPURLResponse else { fatalError() }
        guard (200...299).contains(response.statusCode) else {
            if let message = try? decoder.decode(OpenAIErrorWrapper.self, from: data) {
                throw APIRequestError.openAIError(message.error)
            } else {
                throw APIRequestError.statusCode(response.statusCode)
            }
        }
        let decoded = try decoder.decode(Response.self, from: data)
        return decoded
    }
}

