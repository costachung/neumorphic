# Neumorphic SwiftUI : Neumorphism Soft UI

[![Swift Package Index](https://img.shields.io/endpoint?url=https://swiftpackageindex.com/api/packages/gewill/neumorphic/badge?type=swift-versions)](https://swiftpackageindex.com/gewill/neumorphic) [![Platforms](https://img.shields.io/endpoint?url=https://swiftpackageindex.com/api/packages/gewill/neumorphic/badge?type=platforms)](https://swiftpackageindex.com/gewill/neumorphic) [![License](https://img.shields.io/github/license/gewill/neumorphic)](https://github.com/gewill/neumorphic/blob/master/LICENSE)

Neumorphic is a SwiftUI component library for building soft, accessible interfaces with reusable controls, view modifiers, button styles, and toggle styles.

Hi, I’m Costa. It is simple to create outer shadow in SwiftUI by writing two lines of code. However, we can’t easily create inner shadow in SwiftUI. That’s the reason why I build this tool to make it simple and reusable.

![Image of Neumorphic SwiftUI](https://user-images.githubusercontent.com/169746/77291563-7bfcda80-6d19-11ea-84ff-1ae527e425fa.png)


## Installation
Requirements

- Swift 5.7+ (Xcode 14+)
- iOS 13.0+
- macOS 10.15+

The upcoming release line requires Swift 5.7 / Xcode 14 or newer. Keep using the 2.1.x release line with Xcode 13 or earlier.

#### Swift Package Manager 
1. In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency.
2. Paste the repository URL (https://github.com/gewill/neumorphic.git) and click Next.
3. For Rules, select version.
4. Click Finish.

#### Swift Package
```swift
.package(url: "https://github.com/gewill/neumorphic.git", from: "2.2.0")
```

## Usage
Import Neumorphic package to your view.

```swift
import Neumorphic
```

### Controls

In addition to button and toggle styles, Neumorphic 2.2 provides:

- Input: `NeumorphicSlider`, `NeumorphicTextField`, `NeumorphicStepper`, and `NeumorphicDatePicker`.
- Selection: `NeumorphicPicker`, `NeumorphicCheckbox`, `NeumorphicRadio`, and `NeumorphicMenu`.
- Status and layout: `NeumorphicProgressView`, `NeumorphicCircularProgressView`, `NeumorphicDisclosureGroup`, and `neumorphicCard`.
- Navigation: `NeumorphicLink`.

```swift
VStack(spacing: 20) {
    NeumorphicSlider(value: $volume, in: 0...100, step: 1)
    NeumorphicTextField("Name", text: $name)
    NeumorphicProgressView(value: progress)
    NeumorphicPicker(selection: $mode, options: ["Light", "Dark"])
}
```

`NeumorphicMenu` and `NeumorphicLink` require iOS 14+/macOS 11+; the remaining controls support the package's base deployment targets.

Simply use **.softOuterShadow** and **.softInnerShadow** methods to create outer shadow and inner shadow respectively.

#### Create Rounded Rectangle with Outer Shadow

![Neumorphic SwiftUI Outer Shadow](https://user-images.githubusercontent.com/169746/77294908-fcbed500-6d1f-11ea-9125-cab24891a03d.png)

```swift
RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
```

#### Create Rounded Rectangle with Inner Shadow

![Neumorphic SwiftUI Inner Shadow](https://user-images.githubusercontent.com/169746/77295134-57f0c780-6d20-11ea-8e40-88b7a15319aa.png)

```swift
RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 20))
```

#### Create Circles
![Neumorphic SwiftUI Circles](https://user-images.githubusercontent.com/169746/77296271-60e29880-6d22-11ea-942b-23d4e503f03e.png)

```swift
  HStack {
      Circle().fill(Color.Neumorphic.main).softOuterShadow()
      Circle().fill(Color.Neumorphic.main).softInnerShadow(Circle())
  }
```

#### Create Soft Button
![Neumorphic SwiftUI Button](https://user-images.githubusercontent.com/169746/77301621-f6822600-6d2a-11ea-9248-88a4fa6c9abc.png)
```swift
Button(action: {}) {
    Text("Soft Button").fontWeight(.bold)
}
.neumorphicThemedButtonStyle(RoundedRectangle(cornerRadius: 20))
```

#### Create Soft Button with custom style
![Neumorphic SwiftUI Button](https://user-images.githubusercontent.com/169746/77302381-34337e80-6d2c-11ea-96d6-6409a7e14c92.png)
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

## Customization 

#### softInnerShadow
You can change the color, spread of the shadow, and the shadow radius of the inner shadow.
```swift
softInnerShadow<S : Shape>(_ content: S, darkShadow: Color, lightShadow: Color, spread: CGFloat, radius: CGFloat)
```
#### softOuterShadow
You can change the color, offset of the shadow, and the shadow radius of the outer shadow.
```swift
softOuterShadow(darkShadow: Color, lightShadow: Color, offset: CGFloat, radius:CGFloat)
```

![Neumorphic SwiftUI Search bar](https://user-images.githubusercontent.com/169746/77886613-c8a56000-729b-11ea-87d8-3742146645e6.png)

Example of using background method to add it under TextField:
```swift
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(secondaryColor).font(Font.body.weight(.bold))
                    TextField("Search ...", text: $name).foregroundColor(secondaryColor)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30).fill(mainColor)
                    .softInnerShadow(RoundedRectangle(cornerRadius: 30), darkShadow: darkShadowColor, lightShadow: lightShadowColor, spread: 0.05, radius: 2)
                )
            }
            .padding()
```


Or, something like this:

![Neumorphic SwiftUI bar chart](https://user-images.githubusercontent.com/169746/77887392-1078b700-729d-11ea-911c-3fd94ba1b9e0.png)
```swift
ZStack(alignment: .bottom){
                RoundedRectangle(cornerRadius: 20).fill(mainColor)
                .softInnerShadow(RoundedRectangle(cornerRadius: 20), darkShadow: darkShadow, lightShadow: lightShadow, spread: 0.3, radius: 2)
                .frame(width: 30, height:150)
                
                RoundedRectangle(cornerRadius: 20).fill(barColor)
                    .frame(width: 30, height:100)
            }
```


## Example Project
Open the file-synchronized, multi-platform **neumorphic-examples** Xcode project to explore every control on iOS and macOS, including theme and accessibility previews.


## Soft Button Style Customization
```swift
neumorphicThemedButtonStyle<S: Shape>(
    _ shape: S,
    padding: CGFloat,
    pressedEffect: SoftButtonPressedEffect
)
```

Use `SoftDynamicButtonStyle` directly when a button needs colors that differ from the current `NeumorphicTheme`.

## Soft Button - Pressed Effects

![ezgif-4-88fec6ab5eaa](https://user-images.githubusercontent.com/169746/89747202-400fb980-daf0-11ea-8e23-64fb5b0bfc3c.gif)

```swift
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Text(".none").fontWeight(.bold)
                        }.neumorphicThemedButtonStyle(Capsule(), pressedEffect: .none)
                        Spacer()
                        Button(action: {}) {
                            Text(".flat").fontWeight(.bold)
                        }.neumorphicThemedButtonStyle(Capsule(), pressedEffect: .flat)
                        Spacer()
                        Button(action: {}) {
                            Text(".hard").fontWeight(.bold)
                        }.neumorphicThemedButtonStyle(Capsule(), pressedEffect: .hard)
                        Spacer()
                    }
```

## Soft Toggle 

## SoftSwitchToggleStyle
![Screen Shot 2020-12-12 at 4 16 16 PM](https://user-images.githubusercontent.com/169746/101979392-ce12d100-3c97-11eb-9d45-4e82cef6337b.png)

```swift
Toggle("Toggle", isOn: $toggleIsOn)
  .toggleStyle(NeumorphicSwitchToggleStyle(tint: .green, labelsHidden: true))
```

For the standalone toggle style, use the unambiguous SwiftUI-compatible entry point:

```swift
Toggle("Toggle", isOn: $toggleIsOn)
  .toggleStyle(.neumorphicSwitch)
```

## SoftToggleStyle
![b500](https://user-images.githubusercontent.com/169746/101979866-b76e7900-3c9b-11eb-8d47-ef6f12fa1061.jpeg)

For example, Play and Stop Button
```swift
    Toggle(isOn: $toggleIsOn, label: {
        if toggleIsOn {
            Image(systemName: "stop.fill")
                .font(.title)
        }
        else{
            Image(systemName: "play.fill")
                .font(.title)
        }
    })
    .neumorphicThemedToggleStyle(Circle(), padding: 20)
```

## Themes, Light Mode, and Dark Mode

Default `Color.Neumorphic` colors adapt to light and dark mode automatically. Use an environment theme for a custom palette or the included high-contrast preset. Built-in controls read this theme; buttons and toggles expose explicit themed style modifiers.

```swift
VStack {
    NeumorphicTextField("Name", text: $name)
    Button("Save") { }
        .neumorphicThemedButtonStyle(RoundedRectangle(cornerRadius: 12))
}
.neumorphicTheme(.highContrast)
```

Use `NeumorphicShadowPreset.standard`, `.subtle`, or `.none` to balance visual depth and rendering cost:

```swift
RoundedRectangle(cornerRadius: 16)
    .fill(Color.Neumorphic.main)
    .softOuterShadow(.subtle)
```

`NeumorphicKit.colorSchemeType` remains available for source compatibility when an app must override the legacy global color resolution. Prefer SwiftUI's `preferredColorScheme(_:)` and `.neumorphicTheme(_:)` for new code.

## Accessibility

Custom controls provide VoiceOver labels, values, traits, and adjustable actions on the full supported deployment range. Interactive targets are at least 44 points, selection uses symbols as well as color, and animated controls respect Reduce Motion. Keep labels specific by passing `accessibilityLabel` to sliders and progress indicators, and test with VoiceOver, Larger Text, Increase Contrast, Reduce Motion, and a hardware keyboard on macOS.


## Contacts
https://twitter.com/costachung

# License
Neumorphic Package is released under the MIT license. See the LICENSE file for more info.
