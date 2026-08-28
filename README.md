# Neumorphic

[![Swift versions](https://img.shields.io/endpoint?url=https://swiftpackageindex.com/api/packages/gewill/neumorphic/badge?type=swift-versions)](https://swiftpackageindex.com/gewill/neumorphic) [![Platforms](https://img.shields.io/endpoint?url=https://swiftpackageindex.com/api/packages/gewill/neumorphic/badge?type=platforms)](https://swiftpackageindex.com/gewill/neumorphic) [![CI](https://img.shields.io/github/actions/workflow/status/gewill/neumorphic/ci.yml?branch=master&label=CI)](https://github.com/gewill/neumorphic/actions/workflows/ci.yml) [![License](https://img.shields.io/github/license/gewill/neumorphic)](https://github.com/gewill/neumorphic/blob/master/LICENSE)

A SwiftUI library for soft, tactile "neumorphism" interfaces — the two shadow modifiers the style depends on, plus a set of accessible controls built on top of them.

SwiftUI gives you an outer shadow in one line. It has no inner shadow, and neumorphism needs both. This package supplies the missing half, then uses it consistently across buttons, toggles, sliders, fields, and the rest so a whole screen can share one soft surface.

![Neumorphic SwiftUI](https://user-images.githubusercontent.com/169746/77291563-7bfcda80-6d19-11ea-84ff-1ae527e425fa.png)

## About this fork

This is a fork of [costachung/neumorphic](https://github.com/costachung/neumorphic) by Costa Chung, who designed the original shadow modifiers and button styles. Upstream's last commit was October 2024, at `v2.0.7`; everything from `v2.1.0` onward lives here.

What this fork has added since that point:

- **A real control set.** Slider, TextField, Stepper, DatePicker, Picker, Checkbox, Radio, Menu, ProgressView (linear and circular), DisclosureGroup, Link, and a card modifier — so you aren't hand-rolling every widget out of raw shadows.
- **Accessibility as a baseline, not an afterthought.** VoiceOver labels, values and adjustable actions, 44-point hit targets, non-color selection cues, Dynamic Type layouts, Reduce Motion handling, and macOS keyboard focus.
- **Environment themes.** `.neumorphicTheme(_:)` with a built-in high-contrast preset, plus shadow presets to trade visual depth against rendering cost.
- **Modern toolchain.** Swift 6 strict-concurrency clean, a DocC catalog, Swift Package Index integration, and CI that checks formatting, both deployment-target floors, DocC, and API compatibility against the previous release tag.

I maintain this for my own projects and plan to keep it current. Issues and pull requests are welcome — just treat it as a small single-maintainer package rather than a large community effort. Upstream remains the original work and its license carries through unchanged.

## Requirements

| | |
|---|---|
| Swift | 5.7+ (Xcode 14+) |
| iOS | 13.0+ |
| macOS | 10.15+ |

`NeumorphicMenu` and `NeumorphicLink` need iOS 14+ / macOS 11+. Everything else works on the base deployment targets.

Staying on Xcode 13 or earlier? Pin to the `2.1.x` line — `2.2.0` raised the Swift tools version to 5.7.

## Installation

### Xcode

File → Add Package Dependencies, paste `https://github.com/gewill/neumorphic.git`, and pick a version rule.

### Package.swift

```swift
.package(url: "https://github.com/gewill/neumorphic.git", from: "2.2.1")
```

Then import it:

```swift
import Neumorphic
```

## The two shadows

Everything else in this library is built out of these.

### Outer shadow

![Outer shadow](https://user-images.githubusercontent.com/169746/77294908-fcbed500-6d1f-11ea-9125-cab24891a03d.png)

```swift
RoundedRectangle(cornerRadius: 20)
    .fill(Color.Neumorphic.main)
    .softOuterShadow()
```

### Inner shadow

![Inner shadow](https://user-images.githubusercontent.com/169746/77295134-57f0c780-6d20-11ea-8e40-88b7a15319aa.png)

```swift
RoundedRectangle(cornerRadius: 20)
    .fill(Color.Neumorphic.main)
    .softInnerShadow(RoundedRectangle(cornerRadius: 20))
```

Note that `softInnerShadow` takes the shape as an argument — it needs to know what to clip against, which is exactly the thing SwiftUI's built-in shadow can't do.

### Both, side by side

![Circles](https://user-images.githubusercontent.com/169746/77296271-60e29880-6d22-11ea-942b-23d4e503f03e.png)

```swift
HStack {
    Circle().fill(Color.Neumorphic.main).softOuterShadow()
    Circle().fill(Color.Neumorphic.main).softInnerShadow(Circle())
}
```

### Tuning them

```swift
func softOuterShadow(
    darkShadow: Color = Color.Neumorphic.darkShadow,
    lightShadow: Color = Color.Neumorphic.lightShadow,
    offset: CGFloat = 6,
    radius: CGFloat = 3
) -> some View

func softInnerShadow<S: Shape>(
    _ content: S,
    darkShadow: Color = Color.Neumorphic.darkShadow,
    lightShadow: Color = Color.Neumorphic.lightShadow,
    spread: CGFloat = 0.5,
    radius: CGFloat = 10
) -> some View
```

Or reach for a preset instead of tuning by hand — `.standard`, `.subtle`, or `.none`:

```swift
RoundedRectangle(cornerRadius: 16)
    .fill(Color.Neumorphic.main)
    .softOuterShadow(.subtle)
```

An inset field, for instance, is just a text field over an inner-shadowed background:

![Search bar](https://user-images.githubusercontent.com/169746/77886613-c8a56000-729b-11ea-87d8-3742146645e6.png)

```swift
HStack {
    Image(systemName: "magnifyingglass")
        .foregroundColor(Color.Neumorphic.secondary)
        .font(Font.body.weight(.bold))
    TextField("Search ...", text: $name)
        .foregroundColor(Color.Neumorphic.secondary)
}
.padding()
.background(
    RoundedRectangle(cornerRadius: 30)
        .fill(Color.Neumorphic.main)
        .softInnerShadow(RoundedRectangle(cornerRadius: 30), spread: 0.05, radius: 2)
)
```

And a bar chart is an inner-shadowed track with a plain fill on top:

![Bar chart](https://user-images.githubusercontent.com/169746/77887392-1078b700-729d-11ea-911c-3fd94ba1b9e0.png)

```swift
ZStack(alignment: .bottom) {
    RoundedRectangle(cornerRadius: 20)
        .fill(Color.Neumorphic.main)
        .softInnerShadow(RoundedRectangle(cornerRadius: 20), spread: 0.3, radius: 2)
        .frame(width: 30, height: 150)

    RoundedRectangle(cornerRadius: 20)
        .fill(barColor)
        .frame(width: 30, height: 100)
}
```

## Controls

Rather than rebuilding these on top of the shadow modifiers each time, the package ships them:

| Category | Controls |
|---|---|
| Input | `NeumorphicSlider`, `NeumorphicTextField`, `NeumorphicStepper`, `NeumorphicDatePicker` |
| Selection | `NeumorphicPicker`, `NeumorphicCheckbox`, `NeumorphicRadio`, `NeumorphicMenu` |
| Status | `NeumorphicProgressView`, `NeumorphicCircularProgressView` |
| Layout | `NeumorphicDisclosureGroup`, `.neumorphicCard()` |
| Navigation | `NeumorphicLink` |

```swift
VStack(spacing: 20) {
    NeumorphicSlider(value: $volume, in: 0...100, step: 1)
    NeumorphicTextField("Name", text: $name)
    NeumorphicProgressView(value: progress)
    NeumorphicPicker(selection: $mode, options: ["Light", "Dark"])
}
```

macOS gets two extras: `.neumorphicFocusRing(_:isFocused:)` for keyboard focus and `.neumorphicHover(_:isHovered:)` for pointer feedback.

## Buttons

![Soft button](https://user-images.githubusercontent.com/169746/77301621-f6822600-6d2a-11ea-9248-88a4fa6c9abc.png)

```swift
Button(action: {}) {
    Text("Soft Button").fontWeight(.bold)
}
.neumorphicThemedButtonStyle(RoundedRectangle(cornerRadius: 20))
```

```swift
func neumorphicThemedButtonStyle<S: Shape>(
    _ shape: S,
    padding: CGFloat = 16,
    pressedEffect: SoftButtonPressedEffect = .hard
) -> some View
```

Any shape works, and `SoftDynamicButtonStyle` is there for buttons that need colors outside the current theme:

![Custom button](https://user-images.githubusercontent.com/169746/77302381-34337e80-6d2c-11ea-96d6-6409a7e14c92.png)

```swift
HStack {
    Button(action: {}) {
        Image(systemName: "heart.fill")
    }
    .neumorphicThemedButtonStyle(Circle())

    Button(action: {}) {
        Image(systemName: "heart.fill")
    }
    .buttonStyle(
        SoftDynamicButtonStyle(
            Circle(),
            mainColor: .red,
            textColor: .white,
            darkShadowColor: Color(red: 0.6, green: 0.2, blue: 0.2),
            lightShadowColor: Color("redButtonLightShadow"),
            pressedEffect: .hard
        )
    )
}
```

For a fixed visual size that still keeps a 44-point hit area, use `.fixedSizeSoftButtonStyle(_:size:)`.

### Pressed effects

![Pressed effects](https://user-images.githubusercontent.com/169746/89747202-400fb980-daf0-11ea-8e23-64fb5b0bfc3c.gif)

```swift
HStack {
    Button(action: {}) { Text(".none").fontWeight(.bold) }
        .neumorphicThemedButtonStyle(Capsule(), pressedEffect: .none)
    Button(action: {}) { Text(".flat").fontWeight(.bold) }
        .neumorphicThemedButtonStyle(Capsule(), pressedEffect: .flat)
    Button(action: {}) { Text(".hard").fontWeight(.bold) }
        .neumorphicThemedButtonStyle(Capsule(), pressedEffect: .hard)
}
```

`.hard` presses the surface in, `.flat` removes the shadow, `.none` leaves it alone.

## Toggles

### Switch

![Switch toggle](https://user-images.githubusercontent.com/169746/101979392-ce12d100-3c97-11eb-9d45-4e82cef6337b.png)

```swift
Toggle("Toggle", isOn: $toggleIsOn)
    .toggleStyle(.neumorphicSwitch)
```

Or `.neumorphicThemedSwitchStyle(tint:labelsHidden:height:)` to follow the environment theme, and `NeumorphicSwitchToggleStyle(tint:labelsHidden:)` when you want to configure it directly.

### Shape

![Shape toggle](https://user-images.githubusercontent.com/169746/101979866-b76e7900-3c9b-11eb-8d47-ef6f12fa1061.jpeg)

A toggle that presses in and stays in — good for play/stop:

```swift
Toggle(isOn: $toggleIsOn) {
    Image(systemName: toggleIsOn ? "stop.fill" : "play.fill")
        .font(.title)
}
.neumorphicThemedToggleStyle(Circle(), padding: 20)
```

## Themes, light and dark

`Color.Neumorphic` adapts to light and dark mode on its own. For anything beyond that, put a theme in the environment — built-in controls read it, and the themed button and toggle modifiers follow it:

```swift
VStack {
    NeumorphicTextField("Name", text: $name)
    Button("Save") { }
        .neumorphicThemedButtonStyle(RoundedRectangle(cornerRadius: 12))
}
.neumorphicTheme(.highContrast)
```

`.standard` and `.highContrast` ship with the package; `NeumorphicTheme` is a plain struct, so your own palette is just another value.

`NeumorphicKit.colorSchemeType` still exists for source compatibility with apps that override color resolution globally. New code should prefer `preferredColorScheme(_:)` and `.neumorphicTheme(_:)`.

## Accessibility

Neumorphism is a low-contrast style, which makes accessibility work load-bearing rather than optional. Across the full supported deployment range, the controls here provide VoiceOver labels, values, traits, and adjustable actions; keep at least 44-point interaction targets; signal selection with symbols and not color alone; and respect Reduce Motion in anything animated.

Two things worth doing on your side: pass `accessibilityLabel` to sliders and progress views so VoiceOver announces something more useful than "Slider", and test with VoiceOver, Larger Text, Increase Contrast, Reduce Motion, and a hardware keyboard on macOS.

The design reasoning behind these choices is written up in [Docs](Docs).

## Example project

Open **neumorphic-examples** to browse every control on iOS and macOS, including theme and accessibility previews.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for the checks CI runs — formatting, tests, both deployment-target builds, and a Swift 6 strict-concurrency typecheck. Running them before opening a pull request saves a round trip.

## Credits

Original library by [Costa Chung](https://github.com/costachung) ([@costachung](https://twitter.com/costachung)). Maintained here by [gewill](https://github.com/gewill) since `v2.1.0`.

## License

MIT, unchanged from upstream. See [LICENSE](LICENSE).
