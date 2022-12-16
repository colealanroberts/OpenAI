import Foundation

// MARK: - `OpenAISDK` -

public protocol OpenAISDK {
    /// Connect to OpenAI using your API key, optionally set your organzation which is sent for all requests'
    /// - Returns: `OpenAISDK` for optional chaining
    func connect(with credentials: OpenAI.Credentials) -> Self
    
    /// Asyncronously returns a `Completion` object
    /// - Parameters:
    ///     - request: An `OpenAI.CompletionRequest` request, for basic requests you may choose the alternative `completions(model:prompt:)` method
    /// - Returns: A `Completion` model
    func completions(for request: OpenAI.CompletionRequest) async throws -> Completion
    
    /// Asyncronously returns a `Completion` object, this is a utility method for the more extensible `completions(for:)` method
    /// - Parameters:
    ///     - request: An `OpenAI.CompletionRequest` request
    /// - Returns: A `Completion` model
    func completions(using model: OpenAI.Model, with prompt: String) async throws -> Completion
    
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
    
    private let imageService: ImageServicing
    private let completionService: CompletionServicing
    
    // MARK: - `Init` -
    
    private init() {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        self.imageService = ImageService(decoder: decoder, encoder: encoder)
        self.completionService = CompletionService(decoder: decoder, encoder: encoder)
    }
    
    // MARK: - `Public Methods` -
    
    @discardableResult
    public func connect(with credentials: Credentials) -> Self {
        self.credentials = credentials
        return self
    }
    
    public func images(for request: ImageRequest) async throws -> DataResponse<[Image]> {
        preflightCheck()
        return try await imageService.images(for: request)
    }
    
    public func completions(using model: Model, with prompt: String) async throws -> Completion {
        return try await completions(for: .init(model: model, prompt: prompt))
    }
    
    public func completions(for request: CompletionRequest) async throws -> Completion {
        preflightCheck()
        return try await completionService.completions(for: request)
    }
    
    // MARK: - `Private Methods` -
    
    private func preflightCheck() {
        guard let credentials = credentials, !credentials.isEmpty else {
            preconditionFailure("You must supply `Credentials` before performing a request!")
        }
    }
}
