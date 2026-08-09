# Changelog

## Unreleased

### Breaking

- The minimum Swift tools version is now 5.7 (from 5.3). Xcode 13 and earlier must remain on the 2.1.x release line; publish this change as the next minor release.

### Changed

- Extended environment themes and deployment-target accessibility semantics across the built-in controls.

### Fixed

- Corrected Slider step anchoring, editing callbacks, adjustable actions, and interaction height.
- Added macOS keyboard focus and arrow-key adjustment to Slider.
- Aligned determinate Progress visuals with VoiceOver values and added Reduce Motion-aware indeterminate animation.
- Made default accessibility labels localizable and extended Reduce Motion handling to the legacy button style.
- Preserved custom switch shadow colors and card outer shadows.

### Documentation

- Included the DocC catalog in the package and documented the 2.1 controls, themes, and accessibility behavior.

### Tooling

- Expanded CI to validate release tags, Swift formatting, the macOS 10.15 deployment target, DocC, and API compatibility against the latest preceding release tag.
- Pinned the checkout action and enabled grouped monthly Dependabot updates for GitHub Actions.
- Removed the obsolete manual XCTest list in favor of automatic test discovery.

## 2.1.0 - 2026-08-09

### Added

- Added Neumorphic Slider, TextField, ProgressView, Picker, Stepper, Checkbox, Radio, Card, DatePicker, Menu, DisclosureGroup, Link, and circular ProgressView controls.
- Added Focus Ring, macOS Hover, Theme, high-contrast Theme, and Shadow Preset APIs.
- Added Swift Package Index configuration and README compatibility badges.

### Accessibility

- Added VoiceOver labels, values, adjustable actions, selected states, and 44-point interaction targets for custom controls.
- Improved Dynamic Type layouts, Reduce Motion behavior, disabled-state visibility, and non-color selection cues.

### Tooling

- Added macOS tests, iOS/macOS build validation, Swift 6 strict-concurrency checks, and API breakage diagnostics.
- Removed the tvOS platform declaration and renamed the conflicting public switch style to `NeumorphicSwitchToggleStyle`.
