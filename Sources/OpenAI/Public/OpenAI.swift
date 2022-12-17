import Foundation

// MARK: - `OpenAISDK` -

public protocol OpenAISDK {
    /// Connect to OpenAI using your API key, optionally set your organzation which is sent for all requests'
    /// - Returns: `OpenAISDK` for optional chaining
    func connect(with credentials: OpenAI.Credentials) -> Self
    
    /// Asyncronously returns a `Completion` object
    /// - Parameters:
    ///     - request: An `OpenAI.CompletionRequest` request, for basic requests you may choose the alternative `completions(model:prompt:)` method
    /// - Returns: A `OpenAI.CompletionRequest` model
    func completions(for request: OpenAI.CompletionRequest) async throws -> Completion
    
    /// Asyncronously returns a `Completion` object, this is a utility method for the more extensible `completions(for:)` method
    /// - Parameters:
    ///     - request: An `OpenAI.CompletionRequest.Model`
    /// - Returns: A `Completion` model
    func completions(using model: OpenAI.CompletionRequest.Model, with prompt: String) async throws -> Completion
    
    /// Asyncronously returns an array of `Image` objects
    /// - Parameters:
    ///     - request: An `OpenAI.ImageRequest` request.
    /// - Note: `OpenAI.ImageRequest` conforms to `ExpressibleByStringLiteral` which offers additional flexibility when performing this request.
    func images(for request: OpenAI.ImageRequest) async throws -> DataResponse<[Image]>
}

// MARK: - `OpenAI` -

/// `OpenAI`
///
public final class OpenAI: OpenAISDK {
    
    // MARK: - `Static Properties` -
    
    public static let shared: OpenAI = .init()
    
    // MARK: - `Public Properties` -
    
    public private(set) var credentials: Credentials?
    
    // MARK: - `Private Properties` -
    
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    // MARK: - `Init` -
    
    private init() {
        self.decoder = JSONDecoder()
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        self.encoder = encoder
    }
    
    // MARK: - `Public Methods` -
    
    @discardableResult
    public func connect(with credentials: Credentials) -> Self {
        self.credentials = credentials
        return self
    }
    
    public func images(for model: ImageRequest) async throws -> DataResponse<[Image]> {
        return try await request(for: model)
    }
    
    public func completions(using model: OpenAI.CompletionRequest.Model, with prompt: String) async throws -> Completion {
        return try await request(for: CompletionRequest(model: model, prompt: prompt))
    }
    
    public func completions(for model: CompletionRequest) async throws -> Completion {
        return try await request(for: model)
    }
    
    // MARK: - `Private Methods` -
    
    private func preflightCheck() {
        guard let credentials = credentials, !credentials.isEmpty else {
            preconditionFailure("You must supply `Credentials` before performing a request!")
        }
    }
    
    private func request<T: Requestable, U: Decodable>(for request: T) async throws -> U {
        preflightCheck()
        return try await OpenAI.ConcreteRequest<T, U>(request: request).send(decoder, encoder)
    }
}
