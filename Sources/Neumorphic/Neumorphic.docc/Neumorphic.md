# ``Neumorphic``

Build soft, neumorphic interfaces with SwiftUI view modifiers, button styles, and toggle styles.

## Accessibility

Custom controls expose VoiceOver labels and values where supported by the deployment target. `NeumorphicSlider` supports adjustable actions, `NeumorphicProgressView` reports its percentage or loading state, and selection controls report their selected state. Keep labels specific by providing `accessibilityLabel` for sliders and progress indicators, and test with VoiceOver, Larger Text, Increase Contrast, Reduce Motion, and a hardware keyboard on macOS.

All interactive targets use a minimum 44-point hit area. Visual states also include text or symbols so selection is not communicated by color alone. On iOS 14+/macOS 11+, the semantic modifiers provide labels, values, and adjustable actions; the package keeps its iOS 13/macOS 10.15 deployment compatibility.

`NeumorphicMenu` and `NeumorphicLink` follow SwiftUI availability and require iOS 14+/macOS 11+; the other controls remain available on the package's base deployment targets.

## Overview

The package supports iOS 13.0 and later and macOS 10.15 and later. Use the default colors in ``Color/Neumorphic`` to get light and dark appearance support, or provide custom colors to the styles and modifiers.

```swift
import Neumorphic

Button("Save") { }
    .softButtonStyle(RoundedRectangle(cornerRadius: 12))

Toggle("Enabled", isOn: $isEnabled)
    .toggleStyle(.neumorphicSwitch)

Button("Save") { }
    .neumorphicTheme(.highContrast)
    .neumorphicThemedButtonStyle(Capsule())

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
- ``View/neumorphicCard(_:padding:preset:)``
- ``NeumorphicDatePicker``
- ``NeumorphicMenu``
- ``NeumorphicDisclosureGroup``
- ``NeumorphicLink``
- ``NeumorphicCircularProgressView``

### Appearance

- ``Color/Neumorphic``
- ``NeumorphicKit``
