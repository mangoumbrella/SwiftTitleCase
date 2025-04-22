# SwiftTitleCase

A Swift package that tries its best to transform strings to [AP style title case](https://en.wikipedia.org/wiki/Title_case#AP_Stylebook).

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmangoumbrella%2FSwiftTitleCase%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/mangoumbrella/SwiftTitleCase)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmangoumbrella%2FSwiftTitleCase%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/mangoumbrella/SwiftTitleCase)

## Example usage

```swift
import SwiftTitleCase

let titleCased = "mango baby is a product under mango umbrella".titleCase()
print(titleCased)  // Mango Baby Is a Product Under Mango Umbrella
```

## Why SwiftTitleCase?

[Mango Umbrella](https://mangoumbrella.com/umbrella) has an in-house client app managing its content. I needed a convenience button that automatically transforms my blog post's titles to AP style title case. So I wrote a basic function just doing that.

## Why "tries its best"?

Currently the implementation only handles the basic rules. It doesn't attempt to identify parts of speech contextually. For example, if "up" is used as an adverb rather than a preposition, this package would still lowercase it (unless it's the first or last word). Contributions welcome!

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

## License

[SwiftTitleCase](https://github.com/mangoumbrella/SwiftTitleCase) is licensed under the terms of the Apache license. See [LICENSE](LICENSE) for more information.
