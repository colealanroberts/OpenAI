# OpenAI

A Swift package for interacting with OpenAI
  - [x] Request N completions using the [Completions API](https://beta.openai.com/docs/api-reference/completions/create)
  - [x] Requesting N images using the [Image Generation API](https://beta.openai.com/docs/guides/images)
    - [ ] Creating an image mask
  
## Quick Start

**Connecting**

Import `OpenAI` and then add your API key from [OpenAI](https://openai.com/api/). The API can be initialized directly or accessed using the static `shared` property.

```swift
import OpenAI

...

OpenAI.shared.connect(with: "your-key")
// or
let openai = OpenAI(credentials: "your-key")
```

**Requesting Completions**

A `OpenAI.CompletionRequest` supplies `nil` values for many of the parameters, though these can be supplied for increased flexibility.
```swift
let completions = try await OpenAI.shared.completions(for: OpenAI.CompletionRequest)
print(completions)
```

The latter `CompletionRequest` may provide any of keys found in the [Completions API](https://beta.openai.com/docs/api-reference/completions/create), with the exception of [logit_bias](https://beta.openai.com/docs/api-reference/completions/create#completions/create-logit_bias).

---

**Requesting Images**

A request can be performed by passing in a `OpenAI.ImageRequest` struct.
```swift
let images = try await OpenAI.shared.images(for: OpenAI.ImageRequest)
print(images) // images[0].url
```

An `ImageRequest` may provide the following—
```swift
struct ImageRequest: ExpressibleByStringLiteral {
    /// A text description of the desired image(s). The maximum length is 1000 characters.
    let prompt: String
    /// The number of images to generate. Must be between 1 and 10.
    let numberOfImages: Int
    // The size of the generated images. (`small`: 256x256, `normal`: 512x512, `large`: 1024x1024x)
    let size: Size
    /// The format in which the generated images are returned. (`json` or `b64JSON`)
    let response: Response 
}
```

## License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Contributing

Please feel free to open a PR with desired changes and a brief description.

## Disclaimer

This package is not endorsed by, directly affiliated with, maintained, authorized, or sponsored by OpenAI.
