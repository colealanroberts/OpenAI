//
//  OpenAI+ChatRequest.swift
//  
//
//  Created by Cole Roberts on 3/2/23.
//

import Foundation

// MARK: - `OpenAI+ChatRequest` -

public extension OpenAI {
    struct ChatRequest {
        /// ID of the model to use. See `Model`
        let model: OpenAI.ChatRequest.Model
        
        /// The messages to generate chat completions for, in the chat format.
        let messages: [Message]
        
        /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the
        /// output more random, while lower values like 0.2 will make it more focused and deterministic
        /// We generally recommend altering this or `top_p` but not both.
        let temperature: Double?
        
        /// An alternative to sampling with temperature, called nucleus sampling, where the model
        /// considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens
        /// comprising the top 10% probability mass are considered.
        /// We generally recommend altering this or temperature but not both.
        let topP: Double?
        
        /// How many chat completion choices to generate for each input message.
        let n: Int?
        
        /// If set, partial message deltas will be sent, like in ChatGPT. Tokens will be sent as data-only
        /// server-sent events as they become available, with the stream terminated by a data:
        /// [DONE] message.
        let stream: Bool?
        
        /// Up to 4 sequences where the API will stop generating further tokens.
        let stop: String?
        
        /// The maximum number of tokens allowed for the generated answer. By default, the number
        /// of tokens the model can return will be (4096 - prompt tokens).
        let maxTokens: Int?
        
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they
        /// appear in the text so far, increasing the model's likelihood to talk about new topics.
        let presencePenalty: Double?
        
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing
        /// frequency in the text so far, decreasing the model's likelihood to repeat the same line
        /// verbatim.
        let frequencyPenalty: Double?

        /// A unique identifier representing your end-user, which can help OpenAI to monitor and
        /// detect abuse.
        let user: String?
        
        public init(
            model: OpenAI.ChatRequest.Model,
            messages: [Message],
            temperature: Double? = nil,
            topP: Double? = nil,
            n: Int? = nil,
            stream: Bool? = nil,
            stop: String? = nil,
            maxTokens: Int? = nil,
            presencePenalty: Double? = nil,
            frequencyPenalty: Double? = nil,
            user: String? = nil
        ) {
            self.model = model
            self.messages = messages
            self.temperature = temperature
            self.topP = topP
            self.n = n
            self.stream = stream
            self.stop = stop
            self.maxTokens = maxTokens
            self.presencePenalty = presencePenalty
            self.frequencyPenalty = frequencyPenalty
            self.user = user
        }
    }
}

// MARK: - `OpenAI.ChatRequest+Model` -

public extension OpenAI.ChatRequest {
    /// See: https://beta.openai.com/docs/models/overview
    enum Model {
        /// See `GPT3`
        case gpt3(GPT3)
        
        public enum GPT3: String {
            /// Most capable GPT-3.5 model and optimized for chat at 1/10th the cost of text-davinci-003.
            /// Will be updated with our latest model iteration.
            case turbo
            
            /// Snapshot of gpt-3.5-turbo from March 1st 2023. Unlike gpt-3.5-turbo,
            /// this model will not receive updates, and will only be supported for a
            /// three month period ending on June 1st 2023.
            case turbo0301
        }
        
        // MARK: - `Utility` -
        
        var stringRepresentation: String {
            switch self {
            case .gpt3(let type):
                switch `type` {
                case .turbo:
                    return "gpt-3.5-turbo"
                case .turbo0301:
                    return "gpt-3.5-turbo-0301"
                }
            }
        }
    }
}

// MARK: - `OpenAI.ChatRequest+Message` -

public extension OpenAI.ChatRequest {
    struct Message {
        let role: Role
        let content: String
        
        // MARK: - `Init` -
        
        public init(
            role: Role,
            content: String
        ) {
            self.role = role
            self.content = content
        }
        
        // MARK: - `Utility` -
        
        public static func assistant(_ content: String) -> Self {
            .init(role: .assistant, content: content)
        }
        
        public static func system(_ content: String) -> Self {
            .init(role: .system, content: content)
        }
        
        public static func user(_ content: String) -> Self {
            .init(role: .user, content: content)
        }
    }
}

// MARK: - `OpenAI.ChatRequest.Message+Role` -

public extension OpenAI.ChatRequest.Message {
    enum Role: String {
        case assistant
        case system
        case user
        
        // MARK: - `Utility` -
        
        var stringRepresentation: String {
            rawValue
        }
    }
}
