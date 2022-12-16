import XCTest
@testable import OpenAI

final class MockOpenAITests: XCTestCase {
    
    // MARK: - `Private Properties` -
    
    private var openai: OpenAISDK!
    
    // MARK: - `Lifecycle` -
    
    override func setUp() async throws {
        self.openai = MockOpenAI()
    }
    
    // MARK: - Images
    
    func test_makeImageRequest() async {
        do {
            let images = try await openai.images(for: "A mock request")
            assert(!images.data.isEmpty)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Completions (Basic)
    
    func test_makeBasicCompletionRequest() async {
        do {
            let completions = try await openai.completions(using: .gpt3(.davinci), with: "Say this is a test")
            assert(completions.created == 0)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Completions (Complex)
    
    func test_makeComplexCompletionRequest() async {
        do {
            let completions = try await openai.completions(for: .init(model: .gpt3(.davinci), prompt: "Say this is a test"))
            assert(completions.created == 0)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
