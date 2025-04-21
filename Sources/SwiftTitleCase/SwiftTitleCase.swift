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
    /// Converts a string to title case.
    ///
    /// - Parameters:
    ///   - style: The style of title case to use.
    ///   - preserveCase: Whether to preserve the existing capitalization of the words (except the first letter and lowercase words).
    ///
    /// - Returns: The title case string.
    func titleCase(style _: TitleCaseTyle = .AP, preserveCase: Bool = true) -> String {
        let words = components(separatedBy: " ")
        guard !words.isEmpty else { return self }

        let result = words.enumerated().map { index, word in
            guard !word.isEmpty else { return word }

            // Always capitalize first and last word
            if index == 0 || index == words.count - 1 {
                return capitalizeWord(word, preserveCase: preserveCase, beforeWord: index == 0 ? nil : words[index-1])
            }
            if lowercaseWords.contains(word.lowercased()) {
                return word.lowercased()
            }

            return capitalizeWord(word, preserveCase: preserveCase, beforeWord: index == 0 ? nil : words[index-1])
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

fileprivate struct Transform {
    let value: String
    // Only transform if the word (lowercased) before is in this `beforeWords` set.
    let beforeWords: Set<String>?

    init(_ value: String, _ beforeWords: Set<String>? = nil) {
        self.value = value
        self.beforeWords = beforeWords
    }
}

fileprivate let specialCaseWords: [String: Transform] = [
    // Names
    "mcdonald": .init("McDonald"),
    // Products
    "ipad": .init("iPad"),
    "iphone": .init("iPhone"),
    "ipod": .init("iPod"),
    "imac": .init("iMac"),
    "macbook": .init("MacBook"),
    "ios": .init("iOS"),
    "macos": .init("macOS"),
    "watchos": .init("watchOS"),
    "tvos": .init("tvOS"),
    "mini": .init("mini", ["mac", "ipad"]),
    "linkedin": .init("LinkedIn"),
    "youtube": .init("YouTube"),
    // Programming
    "html": .init("HTML"),
    "css": .init("CSS"),
    "javascript": .init("JavaScript"),
    "typescript": .init("TypeScript"),
]

fileprivate func specialCased(_ word: String, beforeWord: String?) -> String? {
    guard let specialCase = specialCaseWords[word.lowercased()] else {
        return nil
    }
    if let beforeWords = specialCase.beforeWords {
        guard let beforeLowercased = beforeWord?.lowercased() else {
            return nil
        }
        if beforeWords.contains(beforeLowercased) {
            return specialCase.value
        }
        return nil
    } else {
        return specialCase.value
    }
}

fileprivate func capitalizeWord(_ word: String, preserveCase: Bool, beforeWord: String?) -> String {
    guard !word.isEmpty else { return word }

    if word.contains("-") {
        return word.components(separatedBy: "-")
            .map { capitalizeWord($0, preserveCase: preserveCase, beforeWord: beforeWord) }
            .joined(separator: "-")
    }
    if !word.contains("'") && !word.contains("’") {
        if let specialCase = specialCased(word, beforeWord: beforeWord) {
            return specialCase
        } else {
            var result = word
            let firstChar = result.removeFirst()
            if preserveCase {
                return String(firstChar).uppercased() + result
            } else {
                return String(firstChar).uppercased() + result.lowercased()
            }
        }
    }
    var parts = splitWithApostrophes(word)
    for (index, part) in parts.enumerated() {
        if let specialCase = specialCased(part, beforeWord: beforeWord) {
            parts[index] = specialCase
        } else if index == 0 || part.count > 1 {
            // Only apply if the apostrophe is near the start (like O'Neill, not McDonald's)
            var part = part
            let firstChar = part.removeFirst()
            if preserveCase {
                parts[index] = String(firstChar).uppercased() + part
            } else {
                parts[index] = String(firstChar).uppercased() + part.lowercased()
            }
        }
    }
    return parts.joined()
}


fileprivate func splitWithApostrophes(_ input: String) -> [String] {
    let pattern = "([^'’]+|['’])"
    guard let regex = try? NSRegularExpression(pattern: pattern) else {
        return [input]
    }
    let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
    return matches.compactMap { match in
        guard let range = Range(match.range, in: input) else { return nil }
        return String(input[range])
    }
}
