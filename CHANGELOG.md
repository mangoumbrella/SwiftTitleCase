# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com),
and this project adheres to [Semantic Versioning](https://semver.or).

## [Unreleased]

### Fixed

- Renamed `TitleCaseTyle` to `TitleCaseStyle` (typo fix; **breaking change** for callers that referenced the type by name).
- Fixed a typo ("sourse") in the test suite.

### Added

- Added `visionOS` to the special-case word list.

### Changed

- `lowercaseWords` is now a `Set<String>` instead of an `Array`, giving O(1) membership tests.
- The apostrophe-splitting `NSRegularExpression` is now compiled once at module load instead of on every call.

## v0.3.1

### Changed

- Downgrade the `swift-tools-version` to 5.8 so older toolchains can use SwiftTitleCase.

## v0.3.0

### Changed

- Product names like _iPad mini_ and _Mac mini_ are now cased correctly.

## v0.2.0

### Changed

- `.titleCase()` now preserves capitalized letters (except first letter and lowercase words) by default.

## v0.1.0

- Initial release
