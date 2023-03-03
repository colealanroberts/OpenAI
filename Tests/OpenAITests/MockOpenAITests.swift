import XCTest
@testable import OpenAI

final class MockOpenAITests: XCTestCase {
    
    // MARK: - `Private Properties` -
    
    private var openai: OpenAISDK!
    
    // MARK: - `Lifecycle` -
    
    override func setUp() async throws {
        self.openai = MockOpenAI()
    }
    
    // MARK: - Chats
    
    func test_chatRequest() async {
        do {
            let chats = try await openai.chats(
                for: .init(
                    model: .gpt3(.turbo),
                    messages: [
                        .system(content: "You are a helpful assistant."),
                        .user(content: "Who won the world series in 2020?"),
                        .assistant(content: "The Los Angeles Dodgers won the World Series in 2020."),
                        .user(content: "Where was it played?")
                    ]
                )
            )
            assert(!chats.choices.isEmpty)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Completions
    
    func test_completionRequest() async {
        do {
            let completions = try await openai.completions(
                for: .init(
                    model: .gpt3(.davinci),
                    prompt: "Say this is a test")
            )
            assert(!completions.choices.isEmpty)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Images
    
    func test_imageRequest() async {
        do {
            let images = try await openai.images(
                for: .init(prompt: "A white siamese cat")
            )
            assert(!images.data.isEmpty)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
