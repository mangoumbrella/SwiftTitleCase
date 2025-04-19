# SwiftTitleCase

A Swift package that tries its best to transform strings to [AP style title case](https://en.wikipedia.org/wiki/Title_case#AP_Stylebook).

## Example usage

```swift
import SwiftTitleCase

let titleCased = "under the mango umbrella".titleCase()
```

## Why "tries its best"?

Currently the implementation only handles the basic rules. It doesn't attempt to identify parts of speech contextually. For example, if "up" is used as an adverb rather than a preposition, this package would still lowercase it (unless it's the first or last word). Contributions welcome!

## License

[SwiftTitleCase](https://github.com/mangoumbrella/SwiftTitleCase) is licensed under the terms of the Apache license. See [LICENSE](LICENSE) for more information.
