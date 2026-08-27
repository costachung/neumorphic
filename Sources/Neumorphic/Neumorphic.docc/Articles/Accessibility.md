# Accessibility

What the package guarantees, and what still needs your attention.

## Overview

Neumorphism is a low-contrast style by construction: edges are implied by soft shadow rather than drawn
by a border, and a pressed control differs from a raised one only in how the light falls. That makes
accessibility load-bearing here in a way it is not for a high-contrast design — the same visual choice
that gives the style its character is the one that can make a control unreadable or undiscoverable.

The controls in this package handle the parts that can be handled once, in the library. The rest is
listed under **What you still need to do** below.

## What the package handles

**VoiceOver semantics.** Controls carry labels, values, and traits rather than shipping as unlabeled
shapes. ``Neumorphic/NeumorphicSlider`` exposes an adjustable action so VoiceOver users can change the value with
swipe gestures, progress indicators report a clamped percentage or a loading state, and selection
controls report whether they are selected.

**Hit targets.** Interactive controls reserve at least 44 points in the direction that matters, even
where the drawn surface is smaller. `fixedSizeSoftButtonStyle(_:mainColor:textColor:darkShadowColor:lightShadowColor:pressedEffect:size:)`
keeps its 44-point target while rendering at whatever visual size you asked for, so a compact icon
button stays reachable.

**Selection without color.** Selected states add a symbol or text rather than relying on a color change
alone, so the distinction survives color-vision differences and grayscale.

**Reduce Motion.** Animated controls check `accessibilityReduceMotion` and drop their animation when it
is on. This covers the button and toggle styles, both progress indicators, the focus ring, and the hover
effect — anything in the package that would otherwise move.

**Keyboard on macOS.** ``Neumorphic/NeumorphicSlider`` is focusable and responds to arrow keys, drawing a visible
focus ring while it holds focus.

**Default contrast.** `Color.Neumorphic.secondary` — the default text and symbol color — is chosen to
clear WCAG AA against the default surface. If you replace it through a custom ``Neumorphic/NeumorphicTheme``, that
guarantee is yours to re-establish.

## What you still need to do

**Give sliders and progress views a real label.** Both default to a generic label. Pass
`accessibilityLabel` so VoiceOver announces the actual quantity:

```swift
NeumorphicSlider(value: $volume, in: 0...100, step: 1, accessibilityLabel: "Volume")
NeumorphicProgressView(value: progress, accessibilityLabel: "Upload progress")
```

**Label your own soft-styled controls.** The button and toggle *styles* apply a visual treatment to
whatever you hand them; they cannot invent a label for an icon-only button. Use
`neumorphicButtonAccessibility(label:hint:)` when the visible content is a symbol:

```swift
Button(action: archive) {
    Image(systemName: "archivebox")
}
.neumorphicButtonAccessibility(label: "Archive", hint: "Moves this item to the archive")
.neumorphicThemedButtonStyle(Circle())
```

**Reconsider contrast when you theme.** A custom palette can quietly fall below AA. ``Neumorphic/NeumorphicTheme``
ships a `.highContrast` preset built for low-vision use and for demonstrating the difference:

```swift
VStack {
    // ...
}
.neumorphicTheme(.highContrast)
```

**Do not let depth carry meaning alone.** Raised versus inset is a useful convention, but it is a
low-contrast signal. Where the distinction matters — selected, disabled, invalid — pair it with text,
a symbol, or a trait.

## Test with

VoiceOver, Larger Text, Increase Contrast, Reduce Motion, and a hardware keyboard on macOS. The
**neumorphic-examples** project includes a settings screen that toggles the high-contrast theme and
simulates Reduce Motion, which makes these comparisons quick to eyeball on both platforms.

## Availability

``Neumorphic/NeumorphicMenu`` and ``Neumorphic/NeumorphicLink`` follow SwiftUI availability and require iOS 14 or later and
macOS 11 or later. Every other control is available across the package's base deployment targets of
iOS 13 and macOS 10.15, and the accessibility behavior described here applies across that full range.
