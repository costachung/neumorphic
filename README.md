# Neumorphic SwiftUI : Neumorphism Soft UI

Neumorphic is a SwiftUI utility to build Neumorphism Soft UI easily using custom view modifier and custom button style. It supports all shapes. 

Hi, I’m Costa. It is simple to create outer shadow in SwiftUI by writing two lines of code. However, we can’t easily create inner shadow in SwiftUI. That’s the reason why I build this tool to make it simple and reusable.

![Image of Neumorphic SwiftUI](https://user-images.githubusercontent.com/169746/77291563-7bfcda80-6d19-11ea-84ff-1ae527e425fa.png)


## Installation
Requirements
.iOS(.v13),.macOS(.v10_15)

#### Swift Package Manager 
1. In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency.
2. Paste the repository URL (https://github.com/costachung/neumorphic/) and click Next.
3. For Rules, select version.
4. Click Finish.

#### Swift Package
```swift
.package(url: "https://github.com/costachung/neumorphic/", .upToNextMajor(from: "2.0.5"))
```

## Usage
Import Neumorphic package to your view.

```swift
import Neumorphic
```

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
.softButtonStyle(RoundedRectangle(cornerRadius: 20))
```

#### Create Soft Button with custom style
![Neumorphic SwiftUI Button](https://user-images.githubusercontent.com/169746/77302381-34337e80-6d2c-11ea-96d6-6409a7e14c92.png)
```swift
HStack {
    Button(action: {}) {
        Image(systemName: "heart.fill")
    }.softButtonStyle(Circle())

    Button(action: {}) {
        Image(systemName: "heart.fill")
    }.softButtonStyle(Circle(), mainColor: Color.red, textColor: Color.white, darkShadowColor: Color(rgb: 0x993333, alpha: 1), lightShadowColor:Color("redButtonLightShadow"))
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
Check out the __neumorphic-examples__ XCode project to see how to build neumorphic UI and buttons. If you use the default shadow colors of Neumorphic, you can also get dark mode support for free.


## Soft Button Style Customization 
```swift
softButtonStyle<S : Shape>(_ content: S, padding: CGFloat, mainColor: Color, textColor: Color, darkShadowColor: Color, lightShadowColor: Color, pressedEffect: SoftButtonPressedEffect)
```

## Soft Button - Pressed Effects

![ezgif-4-88fec6ab5eaa](https://user-images.githubusercontent.com/169746/89747202-400fb980-daf0-11ea-8e23-64fb5b0bfc3c.gif)

```swift
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Text(".none").fontWeight(.bold)
                        }.softButtonStyle(Capsule(), pressedEffect: .none)
                        Spacer()
                        Button(action: {}) {
                            Text(".flat").fontWeight(.bold)
                        }.softButtonStyle(Capsule(), pressedEffect: .flat)
                        Spacer()
                        Button(action: {}) {
                            Text(".hard").fontWeight(.bold)
                        }.softButtonStyle(Capsule(), pressedEffect: .hard)
                        Spacer()
                    }
```

## Soft Toggle 

## SoftSwitchToggleStyle
![Screen Shot 2020-12-12 at 4 16 16 PM](https://user-images.githubusercontent.com/169746/101979392-ce12d100-3c97-11eb-9d45-4e82cef6337b.png)

```swift
Toggle("Toggle", isOn: $toggleIsOn)
  .softSwitchToggleStyle(tint: .green, labelsHidden: true)
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
    .softToggleStyle(Circle(), padding: 20)
```

## Auto, Light, and Dark Mode for iOS and MacOS

#### Default Neumorphic Colors
Access default neumorphic colors using Color.Neumorphic, for example,
```swift
Color.Neumorphic.main
 ```

#### Auto ColorScheme
- Color.Neumorphic supports light and dark mode on both iOS and MacOS automatically by default.

#### Set the color scheme manually
- When you use default neumorphic colors and you want to set the color scheme manually, you can do it by setting Color.Neumorphic.colorSchemeType to the type you want. For example, to force the color scheme in dark mode, use:
```swift
Color.Neumorphic.colorSchemeType = .dark
 ```


## Contacts
https://twitter.com/costachung

# License
Neumorphic Package is released under the MIT license. See the LICENSE file for more info.
