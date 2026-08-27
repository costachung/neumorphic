# Getting Started

Build your first neumorphic surface, then assemble a screen from the controls that share it.

## Overview

Neumorphism is a single visual idea applied consistently: every element looks pressed out of, or into,
one continuous surface. That effect needs two shadows — a dark one on the lower-right and a light one
on the upper-left. SwiftUI gives you the outer half in one line and has no inner shadow at all, which
is the gap this package fills.

## Add the package

In Xcode, choose File → Add Package Dependencies and enter `https://github.com/gewill/neumorphic.git`,
or add it to a `Package.swift`:

```swift
.package(url: "https://github.com/gewill/neumorphic.git", from: "2.2.0")
```

Then import it wherever you build views:

```swift
import Neumorphic
```

## Start with the surface

Neumorphic surfaces only read correctly against a matching background. Fill the container with
`Color.Neumorphic.main` first — a raised shape on a white background looks like a mistake, not a surface.

```swift
ZStack {
    Color.Neumorphic.main.edgesIgnoringSafeArea(.all)

    RoundedRectangle(cornerRadius: 20)
        .fill(Color.Neumorphic.main)
        .softOuterShadow()
        .frame(width: 200, height: 120)
}
```

Swap `softOuterShadow()` for `softInnerShadow(_:)` to press the shape inward instead. The inner variant
takes the shape as an argument because it has to clip the shadow to that outline:

```swift
RoundedRectangle(cornerRadius: 20)
    .fill(Color.Neumorphic.main)
    .softInnerShadow(RoundedRectangle(cornerRadius: 20))
```

Raised means interactive; inset means a container or a track. Keeping that distinction consistent is
most of what makes a neumorphic screen readable.

## Use the controls instead of rebuilding them

Anything you would assemble by hand from those two modifiers already exists as a control that handles
layout, state, and accessibility:

```swift
struct SettingsPanel: View {
    @State private var volume = 40.0
    @State private var name = ""
    @State private var mode = "Light"
    @State private var notify = true

    var body: some View {
        ZStack {
            Color.Neumorphic.main.edgesIgnoringSafeArea(.all)

            VStack(spacing: 24) {
                NeumorphicTextField("Name", text: $name)
                NeumorphicSlider(value: $volume, in: 0...100, step: 1, accessibilityLabel: "Volume")
                NeumorphicPicker(selection: $mode, options: ["Light", "Dark"])
                NeumorphicCheckbox("Notify me", isOn: $notify)

                Button("Save") { }
                    .neumorphicThemedButtonStyle(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
            .neumorphicCard()
        }
    }
}
```

`neumorphicCard(_:padding:preset:)` wraps any view in a raised surface, so panels nest without you
recomputing shadow colors.

## Theme the whole screen at once

Rather than passing colors to each control, put a ``Neumorphic/NeumorphicTheme`` in the environment. Every built-in
control and every themed modifier below that point picks it up:

```swift
VStack {
    NeumorphicTextField("Name", text: $name)
    Button("Save") { }
        .neumorphicThemedButtonStyle(Capsule())
}
.neumorphicTheme(.highContrast)
```

> Important: Apply `neumorphicTheme(_:)` to an *ancestor* of the views that should adopt it. Environment
values travel downward only, so a themed modifier applied *outside* the `neumorphicTheme(_:)` call reads
the ambient theme and your palette silently does nothing.

`.standard` and `.highContrast` ship with the package, and ``Neumorphic/NeumorphicTheme`` is an ordinary struct, so
your own palette is just another value.

## Control the cost of depth

Every soft surface draws two shadows, which adds up in a long scrolling list. ``Neumorphic/NeumorphicShadowPreset``
trades depth against rendering cost without you tuning numbers by hand:

```swift
RoundedRectangle(cornerRadius: 16)
    .fill(Color.Neumorphic.main)
    .softOuterShadow(.subtle)
```

Use `.standard` for hero surfaces, `.subtle` for dense repeating rows, and `.none` to keep the surface
while dropping the shadow layers entirely.

## Next steps

Neumorphism is a low-contrast style by construction, which makes accessibility work load-bearing rather
than optional. Read <doc:Accessibility> before shipping, and open the **neumorphic-examples** project to
browse every control on iOS and macOS with live theme and accessibility previews.
