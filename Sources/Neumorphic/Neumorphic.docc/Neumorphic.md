# ``Neumorphic``

Build soft, neumorphic interfaces with SwiftUI view modifiers, button styles, and toggle styles.

## Accessibility

Custom controls expose VoiceOver labels and values across the supported deployment range. `NeumorphicSlider` supports adjustable actions, progress indicators report a clamped percentage or loading state, and selection controls report their selected state. Keep labels specific by providing `accessibilityLabel` for sliders and progress indicators, and test with VoiceOver, Larger Text, Increase Contrast, Reduce Motion, and a hardware keyboard on macOS.

All interactive targets use a minimum 44-point hit area. Visual states also include text or symbols so selection is not communicated by color alone, and indeterminate progress animations respect Reduce Motion.

`NeumorphicMenu` and `NeumorphicLink` follow SwiftUI availability and require iOS 14+/macOS 11+; the other controls remain available on the package's base deployment targets.

## Overview

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
        .neumorphicThemedButtonStyle(Capsule())
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

### Styling

- ``SoftDynamicButtonStyle``
- ``FixedSizeSoftDynamicButtonStyle``
- ``SoftDynamicToggleStyle``
- ``SoftSwitchToggleStyle``
- ``NeumorphicSwitchToggleStyle``
- ``NeumorphicFocusRing``
- ``NeumorphicTheme``
- ``NeumorphicShadowPreset``
- ``NeumorphicHoverEffect``
- ``NeumorphicSlider``
- ``NeumorphicTextField``
- ``NeumorphicProgressView``
- ``NeumorphicPicker``
- ``NeumorphicStepper``
- ``NeumorphicCheckbox``
- ``NeumorphicRadio``
- ``NeumorphicDatePicker``
- ``NeumorphicMenu``
- ``NeumorphicDisclosureGroup``
- ``NeumorphicLink``
- ``NeumorphicCircularProgressView``

### View Modifiers

The package provides `softOuterShadow`, `softInnerShadow`, and `neumorphicCard`, plus `neumorphicTheme` and themed button, toggle, and switch styles. Focus, hover, and switch behavior are available through `neumorphicFocusRing`, `neumorphicHover`, and `switchToggleStyle`.

### Appearance

- ``NeumorphicKit``
