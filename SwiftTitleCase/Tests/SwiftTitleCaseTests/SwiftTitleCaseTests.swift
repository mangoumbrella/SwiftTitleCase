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

import Testing
@testable import SwiftTitleCase

@Test func testTitleCase() async throws {
    #expect("hello world".titleCase() == "Hello World")
    #expect("UNDER THE MANGO UMBRELLA".titleCase() == "Under the Mango Umbrella")
    #expect("a tale of two cities".titleCase() == "A Tale of Two Cities")

    // Test first and last word always capitalized
    #expect("in the heat of the night".titleCase() == "In the Heat of the Night")
    #expect("what is this for".titleCase() == "What Is This For")

    // Hyphenated words
    #expect("the well-known story".titleCase() == "The Well-Known Story")

    // Words with apostrophes
    #expect("o'neill's play".titleCase() == "O'Neill's Play")
    // TODO: `McDonald's` is incorrectly cased.
    #expect("mcdonald's restaurant".titleCase() == "McDonald's Restaurant")
    #expect("the king's speech".titleCase() == "The King's Speech")

    // Special case
    #expect("MacBook Pro review".titleCase() == "MacBook Pro Review")
    #expect("iPhone and iPad apps".titleCase() == "iPhone and iPad Apps")

    // Edge cases
    #expect("".titleCase() == "")
    #expect("a".titleCase() == "A")
    #expect("THE".titleCase() == "The")

    // Multiple spaces
    #expect("the  lord  of  the  rings".titleCase() == "The  Lord  of  the  Rings")
}
