//
//  File.swift
//  
//
//  Created by Cole Roberts on 12/15/22.
//

import Foundation

// MARK: - `OpenAI+CompletionRequest` -

public extension OpenAI {
    struct CompletionRequest {
        /// ID of the model to use. See `Model`
        let model: OpenAI.CompletionRequest.Model
        
        /// The prompt(s) to generate completions for, encoded as a string, array of strings, array of tokens, or array of token arrays.
        let prompt: [String]
        
        /// The suffix that comes after a completion of inserted text.
        let suffix: String?
        
        /// The maximum number of tokens to generate in the completion.
        /// The token count of your prompt plus max_tokens cannot exceed the model's context length.
        /// Most models have a context length of 2048 tokens (except for the newest models, which support 4096).
        let maxTokens: Int?
        
        /// What sampling temperature to use. Higher values means the model will take more risks.
        /// Try 0.9 for more creative applications, and 0 (argmax sampling) for ones with a well-defined answer.
        /// - Note: It's generally recommended altering this or top_p but not both.
        let temperature: Double?
        
        /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with
        /// top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
        /// - Note: It's generally recommended altering this or temperature but not both.
        let topP: Double?

        /// How many completions to generate for each prompt.
        /// - Note: Because this parameter generates many completions, it can quickly consume your token quota.
        /// Use carefully and ensure that you have reasonable settings for max_tokens and stop.
        let n: Int?
        
        /// Whether to stream back partial progress. If set, tokens will be sent as data-only server-sent events as they become available,
        /// with the stream terminated by a data: [DONE] message.
        let stream: Bool?
        
        /// Include the log probabilities on the logprobs most likely tokens, as well the chosen tokens. For example, if logprobs is 5, the API
        /// will return a list of the 5 most likely tokens. The API will always return the logprob of the sampled token, so there may be up
        /// to logprobs+1 elements in the response. The maximum value for logprobs is 5. If you need more than this, please contact OpenAI through their
        /// Help center and describe your use case.
        let logprobs: Int?
        
        /// Echo back the prompt in addition to the completion
        let echo: Bool?
        
        /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
        let stop: [String]?
        
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far,
        /// increasing the model's likelihood to talk about new topics.
        let presencePenalty: Double?
        
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far,
        /// decreasing the model's likelihood to repeat the same line verbatim.
        let frequencyPenalty: Double?
        
        /// Generates best_of completions server-side and returns the "best" (the one with the highest log probability per token). Results cannot be streamed.
        /// When used with n, best_of controls the number of candidate completions and n specifies how many to return – best_of must be greater than n.
        /// - Note: Because this parameter generates many completions,
        /// it can quickly consume your token quota. Use carefully and ensure that you have reasonable settings for max_tokens and stop.
        let bestOf: Int?
        
        /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. Learn more.
        let user: String?
        
        public init(
            model: OpenAI.CompletionRequest.Model,
            prompt: String...,
            suffix: String? = nil,
            maxTokens: Int? = nil,
            temperature: Double? = nil,
            topP: Double? = nil,
            n: Int? = nil,
            stream: Bool? = nil,
            logprobs: Int? = nil,
            echo: Bool? = nil,
            stop: [String]? = nil,
            presencePenalty: Double? = nil,
            frequencyPenalty: Double? = nil,
            bestOf: Int? = nil,
            user: String? = nil
        ) {
            self.model = model
            self.prompt = prompt
            self.suffix = suffix
            self.maxTokens = maxTokens
            self.temperature = temperature
            self.topP = topP
            self.n = n
            self.stream = stream
            self.logprobs = logprobs
            self.echo = echo
            self.stop = stop
            self.presencePenalty = presencePenalty
            self.frequencyPenalty = frequencyPenalty
            self.bestOf = bestOf
            self.user = user
        }
    }
}

// MARK: - `OpenAI.CompletionRequest+Model` -

public extension OpenAI.CompletionRequest {
    /// See: https://beta.openai.com/docs/models/overview
    enum Model {
        /// See `GPT3`
        case gpt3(GPT3)
        
        /// See `Codex`
        case codex(Codex)
        
        public enum GPT3 {
            /// Davinci is the most capable model family, able to perform any task the other models can perform, often with less instruction.
            /// It excels at applications requiring a deep understanding of content, such as summarization for a specific audience and creative content generation.
            /// Davinci is also very good at understanding the intent of text and solving logic problems, including those involving cause and effect.
            /// However, these increased capabilities come at a cost, as Davinci requires more compute resources and is therefore more expensive per API call and not as fast as the other models.
            /// - Note: Good at: Complex intent, cause and effect, summarization for audience
            case davinci
            
            /// Curie is a powerful and fast language model. It excels at tasks like sentiment classification and summarization.
            /// It is also very capable at answering questions and serving as a general chatbot.
            /// While Davinci may be stronger at analyzing complicated text, Curie is more than capable for many nuanced tasks.
            /// - Note: Good at: Language translation, complex classification, text sentiment, summarization
            case curie
            
            /// Babbage is capable of performing straightforward tasks like simple classification.
            /// It is also quite proficient at Semantic Search, ranking how well documents match up with search queries.
            /// - Note: Good at: Moderate classification, semantic search classification
            case babbage
            
            /// Ada is generally the fastest model and is capable of tasks such as parsing text, address correction, and certain classification tasks that do not require a lot of nuance.
            /// Its performance can often be improved by providing more context.
            /// - Note: Good at: Parsing text, simple classification, address correction, keywords
            case ada
        }
        
        public enum Codex {
            /// Most capable Codex model. Particularly good at translating natural language to code.
            /// In addition to completing code, also supports inserting completions within code.
            case davinci
            
            /// Almost as capable as Davinci Codex, but slightly faster.
            /// This speed advantage may make it preferable for real-time applications.
            case cushman
        }
        
        // MARK: - `Utility` -
        
        var stringRepresentation: String {
            switch self {
            case .codex(let type):
                switch `type` {
                case .cushman:
                    return "code-cushman-001"
                case .davinci:
                    return "code-davinci-002"
                }
                
            case .gpt3(let type):
                switch `type` {
                case .ada:
                    return "text-ada-001"
                case .babbage:
                    return "text-babbage-001"
                case .curie:
                    return "text-curie-001"
                case .davinci:
                    return "text-davinci-003"
                }
            }
        }
    }
}
