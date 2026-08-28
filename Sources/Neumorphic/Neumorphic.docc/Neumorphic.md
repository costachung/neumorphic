# ``Neumorphic``

Build soft, neumorphic interfaces with SwiftUI view modifiers, button styles, and toggle styles.

## Overview

New here? <doc:GettingStarted> walks through the first surface, the controls, and theming.

The package supports iOS 13.0 and later and macOS 10.15 and later. Use the default `Color.Neumorphic` colors to get light and dark appearance support, or provide an environment `NeumorphicTheme`; built-in controls inherit that theme.

Apply `neumorphicTheme(_:)` to an *ancestor* of the views that should adopt it. Environment values only travel downward, so a themed modifier applied outside the `neumorphicTheme(_:)` call reads the ambient theme instead of the one you supplied.

```swift
import Neumorphic

Button("Save") { }
    .neumorphicThemedButtonStyle(RoundedRectangle(cornerRadius: 12))

Toggle("Enabled", isOn: $isEnabled)
    .toggleStyle(.neumorphicSwitch)

VStack {
    Button("Save") { }
        .neumorphicThemedButtonStyle(Capsule(), role: .accent)
}
.neumorphicTheme(.highContrast)

Text("Save")
    .neumorphicFocusRing(Capsule(), isFocused: $isFocused)

NeumorphicSlider(value: $volume, in: 0...100, step: 1)
NeumorphicTextField("Name", text: $name)
NeumorphicProgressView(value: 0.65)
NeumorphicPicker(selection: $mode, options: ["Light", "Dark"])
NeumorphicStepper("Quantity", value: $quantity, in: 0...10)
NeumorphicCheckbox("Remember me", isOn: $remember)
NeumorphicRadio("Light", value: "light", selection: $mode)
Text("Card content").neumorphicCard()
NeumorphicDatePicker("Start", selection: $date)
NeumorphicMenu("Mode", selection: $mode, options: ["Light", "Dark"])
NeumorphicDisclosureGroup("Details", isExpanded: $expanded) { Text("Content") }
NeumorphicLink("Website", destination: URL(string: "https://example.com")!)
NeumorphicCircularProgressView(value: 0.65)
```

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:Accessibility>

### Shadows

The two modifiers everything else is built from: `softOuterShadow(darkShadow:lightShadow:offset:radius:)` raises a
surface, and `softInnerShadow(_:darkShadow:lightShadow:spread:radius:)` insets one. Both take a
``NeumorphicShadowPreset`` overload when you want `.standard`, `.subtle`, or `.none` instead of hand-tuned geometry.

- ``NeumorphicShadowPreset``

### Theming

- ``NeumorphicTheme``
- ``NeumorphicButtonRole``
- ``NeumorphicKit``

Apply a theme with `neumorphicTheme(_:)` on an ancestor view, then use the themed modifiers —
`neumorphicThemedButtonStyle(_:padding:pressedEffect:)`, `neumorphicThemedButtonStyle(_:role:padding:pressedEffect:)`,
`neumorphicThemedToggleStyle(_:padding:pressedEffect:)`, and
`neumorphicThemedSwitchStyle(tint:labelsHidden:height:)` — on the controls below it.

### Input Controls

- ``NeumorphicSlider``
- ``NeumorphicTextField``
- ``NeumorphicStepper``
- ``NeumorphicDatePicker``

### Selection Controls

- ``NeumorphicPicker``
- ``NeumorphicCheckbox``
- ``NeumorphicRadio``
- ``NeumorphicMenu``

### Progress and Layout

- ``NeumorphicProgressView``
- ``NeumorphicCircularProgressView``
- ``NeumorphicDisclosureGroup``
- ``NeumorphicLink``

Wrap any view in a raised card surface with `neumorphicCard(_:padding:preset:)`.

### Button Styles

- ``SoftDynamicButtonStyle``
- ``FixedSizeSoftDynamicButtonStyle``
- ``SoftButtonPressedEffect``
- ``SoftButtonStyle``

Applied through `softButtonStyle(_:padding:mainColor:textColor:darkShadowColor:lightShadowColor:pressedEffect:)` and
`fixedSizeSoftButtonStyle(_:mainColor:textColor:darkShadowColor:lightShadowColor:pressedEffect:size:)`.

### Toggle Styles

- ``SoftDynamicToggleStyle``
- ``NeumorphicSwitchToggleStyle``
- ``SoftSwitchToggleStyle``

Applied through `softToggleStyle(_:padding:mainColor:textColor:darkShadowColor:lightShadowColor:pressedEffect:)` and
`switchToggleStyle(tint:offTint:mainColor:darkShadowColor:lightShadowColor:labelsHidden:height:)`, or the
`.neumorphicSwitch` shorthand on `toggleStyle(_:)`.

### Focus and Pointer

- ``NeumorphicFocusRing``
- ``NeumorphicHoverEffect``

Applied through `neumorphicFocusRing(_:isFocused:color:lineWidth:)` and `neumorphicHover(_:isHovered:color:lineWidth:)`.
`NeumorphicHoverEffect` is a no-op outside macOS.
