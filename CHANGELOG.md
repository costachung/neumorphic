# Changelog

## 2.2.2 - 2026-08-28

### Accessibility

- Exposed selected state through the standard `.isSelected` accessibility trait on Picker, Checkbox, and Radio controls where available, while retaining the value-based fallback on iOS 13 and macOS 10.15.

### Fixed

- Kept the original Button- and Toggle-specific style entry points available without deprecation warnings. Their more-specific overloads remain necessary for source and binary compatibility in the 2.x release line and are scheduled for removal in 3.0.

### Tooling

- Compiled direct Button and Toggle compatibility calls with warnings treated as errors in CI.

## 2.2.1 - 2026-08-28

### Documentation

- Rewrote the README around this fork's maintenance status, stating where upstream stopped (`v2.0.7`, October 2024) and what has been added since, and reorganized it to introduce the two shadow modifiers before the controls built on them.
- Added a Getting Started article covering installation, the first surface, the controls, theming, and shadow presets.
- Moved accessibility guidance out of the module page into its own article, separating what the package guarantees from what callers still need to do.
- Corrected the DocC theme example, which applied `neumorphicTheme(_:)` inside the themed modifier that reads it. Environment values only travel downward, so the example's `.highContrast` palette silently had no effect.
- Documented parameters for 27 public declarations that had only a one-line summary, covering the view modifiers that make up the primary API.
- Documented the normalization applied to `NeumorphicSlider.step`, `NeumorphicSwitchToggleStyle.height`, and `fixedSizeSoftButtonStyle(size:)`, and surfaced the `spread` range and its effect in the public `softInnerShadow` documentation.
- Regrouped the DocC Topics from a single Styling section into Essentials, Shadows, Theming, control, style, and focus groups, and added the previously unlisted `SoftButtonPressedEffect` and `SoftButtonStyle`.
- Corrected four file headers naming files that no longer exist, and clarified the inline comments in `ColorExtension` and `SoftInnerShadowViewModifier`.

### Tooling

- Added tests for the environment theme default and override, and for `NeumorphicShadowPreset` colour resolution: `.standard` and `.subtle` follow the applied theme, while presets built with explicit colours stay fixed across themes.

## 2.2.0 - 2026-08-09

### Breaking

- The minimum Swift tools version is now 5.7 (from 5.3). Xcode 13 and earlier must remain on the 2.1.x release line.

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
