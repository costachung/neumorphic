# ``Neumorphic``

Build soft, neumorphic interfaces with SwiftUI view modifiers, button styles, and toggle styles.

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

### Appearance

- ``Color/Neumorphic``
- ``NeumorphicKit``
