// Copyright 2025 The SwiftTitleCase Authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

public enum TitleCaseTyle {
    case AP
    // TODO: Add more styles as needed.
}

public extension String {
    func titleCase(style _: TitleCaseTyle = .AP) -> String {
        let words = components(separatedBy: " ")
        guard !words.isEmpty else { return self }

        let result = words.enumerated().map { index, word in
            guard !word.isEmpty else { return word }

            // Always capitalize first and last word
            if index == 0 || index == words.count - 1 {
                return capitalizeFirstLetter(word)
            }
            if lowercaseWords.contains(word.lowercased()) {
                return word.lowercased()
            }

            return capitalizeFirstLetter(word)
        }

        return result.joined(separator: " ")
    }
}

// TODO: These words are not just used as adjectives, so they should be context dependent but not implemented yet.
private let lowercaseWords = [
    "a",
    "an",
    "and",
    "as",
    "at",
    "but",
    "by",
    "for",
    "if",
    "in",
    "nor",
    "of",
    "off",
    "on",
    "or",
    "per",
    "so",
    "the",
    "to",
    "up",
    "via",
    "yet",
]

// TODO: The "mini" in product names like iPad mini, Mac mini should not be capitalized.
private let specialCaseWords = [
    "mcdonald": "McDonald",
    "ipad": "iPad",
    "iphone": "iPhone",
    "ipod": "iPod",
    "imac": "iMac",
    "macbook": "MacBook",
    "ios": "iOS",
    "macos": "macOS",
    "watchos": "watchOS",
    "tvos": "tvOS",
    "linkedin": "LinkedIn",
    "youtube": "YouTube",
    "html": "HTML",
    "css": "CSS",
    "javascript": "JavaScript",
    "typescript": "TypeScript",
]

private func capitalizeFirstLetter(_ word: String) -> String {
    guard !word.isEmpty else { return word }

    if word.contains("-") {
        return word.components(separatedBy: "-")
            .map { capitalizeFirstLetter($0) }
            .joined(separator: "-")
    }

    let lowercasedWord = word.lowercased()
    if let specialCase = specialCaseWords[lowercasedWord] {
        return specialCase
    }
    var result = word
    let firstChar = result.removeFirst()
    result = String(firstChar).uppercased() + result.lowercased()

    // Special handling for words with apostrophes like O'Neill
    if let apostropheIndex = result.firstIndex(of: "'"),
       apostropheIndex != result.endIndex,
       apostropheIndex != result.index(before: result.endIndex)
    {
        let indexAfterApostrophe = result.index(after: apostropheIndex)
        let charAfterApostrophe = result[indexAfterApostrophe]

        // Only apply if the apostrophe is near the start (like O'Neill, not McDonald's)
        if result.distance(from: result.startIndex, to: apostropheIndex) <= 1 {
            result.replaceSubrange(indexAfterApostrophe ... indexAfterApostrophe,
                                   with: String(charAfterApostrophe).uppercased())
        }
    }

    return result
}
