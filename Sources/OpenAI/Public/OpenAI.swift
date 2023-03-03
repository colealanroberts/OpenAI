import Foundation

// MARK: - `OpenAISDK` -

public protocol OpenAISDK {
    /// Connect to OpenAI using your API key, optionally set your organzation which is sent for all requests'
    /// - Returns: `OpenAISDK` for optional chaining
    func connect(with credentials: OpenAI.Credentials) -> Self
    
    /// Asyncronously returns an array of `ChatModel` objects.
    /// - Parameters:
    ///     - request: An `OpenAI.ChatRequest` request.
    /// - Returns: A `OpenAI.ChatModel` model.
    func chats(for model: OpenAI.ChatRequest) async throws -> ChatModel
    
    /// Asyncronously returns a `Completion` object.
    /// - Parameters:
    ///     - request: An `OpenAI.CompletionRequest` request, for basic requests you may choose the alternative `completions(model:prompt:)` method
    /// - Returns: A `OpenAI.CompletionRequest` model.
    func completions(for model: OpenAI.CompletionRequest) async throws -> CompletionModel
    
    /// Asyncronously returns an array of `ImageModel` objects.
    /// - Parameters:
    ///     - request: An `OpenAI.ImageRequest` request.
    /// - Returns: A `Images` model.
    /// - Note: `OpenAI.ImageRequest` conforms to `ExpressibleByStringLiteral` which offers additional flexibility when performing this request.
    func images(for model: OpenAI.ImageRequest) async throws -> ImagesModel
}

// MARK: - `OpenAI` -

/// `OpenAI`
///
/// Instances of this class may be initialized directly, alternatively a
/// singleton instance may be accessed using `OpenAI.shared`.
public final class OpenAI: OpenAISDK {
    
    // MARK: - `Static Properties` -
    
    public static let shared: OpenAI = .init()
    
    // MARK: - `Public Properties` -
    
    public private(set) var credentials: Credentials?
    
    // MARK: - `Private Properties` -
    
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    // MARK: - `Init` -
    
    public convenience init(credentials: Credentials) {
        self.init()
        self.connect(with: credentials)
    }
    
    public init() {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder.keyEncodingStrategy = .convertToSnakeCase
        self.decoder = decoder
        self.encoder = encoder
    }
    
    // MARK: - `Public Methods` -
    
    @discardableResult
    public func connect(with credentials: Credentials) -> Self {
        self.credentials = credentials
        return self
    }
    
    public func chats(for model: ChatRequest) async throws -> ChatModel {
        return try await request(for: model)
    }
    
    public func completions(for model: CompletionRequest) async throws -> CompletionModel {
        return try await request(for: model)
    }
    
    public func images(for model: ImageRequest) async throws -> ImagesModel {
        return try await request(for: model)
    }
    
    // MARK: - `Private Methods` -
    
    private func preflightCheck() -> Credentials {
        guard let credentials = credentials, !credentials.isEmpty else {
            preconditionFailure("You must supply `Credentials` before performing a request!")
        }
        
        return credentials
    }
    
    private func request<Request: Requestable, Response: Decodable>(for request: Request) async throws -> Response {
        return try await OpenAI.ConcreteRequest<Request, Response>(
            credentials: preflightCheck(),
            request: request
        )
        .send(decoder, encoder)
    }
}
