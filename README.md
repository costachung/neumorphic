# Neumorphic SwiftUI : Neumorphism Soft UI

Neumorphic is a SwiftUI utilities to build Neumorphism Soft UI easily using custom view modifier and custom button style. It supports all shapes. 

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
.package(url: "https://github.com/costachung/neumorphic/", .upToNextMajor(from: "1.0.0"))
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
RoundedRectangle(cornerRadius: 20).fill(Neumorphic.shared.mainColor()).softOuterShadow()
```

#### Create Rounded Rectangle with Inner Shadow

![Neumorphic SwiftUI Inner Shadow](https://user-images.githubusercontent.com/169746/77295134-57f0c780-6d20-11ea-8e40-88b7a15319aa.png)

```swift
RoundedRectangle(cornerRadius: 20).fill(Neumorphic.shared.mainColor()).softInnerShadow(RoundedRectangle(cornerRadius: 20))
```

#### Create Circles
![Neumorphic SwiftUI Circles](https://user-images.githubusercontent.com/169746/77296271-60e29880-6d22-11ea-942b-23d4e503f03e.png)

```swift
  HStack {
      Circle().fill(Neumorphic.shared.mainColor()).softOuterShadow()
      Circle().fill(Neumorphic.shared.mainColor()).softInnerShadow(Circle())
  }
```

# License
Neumorphic Package is released under the MIT license. See the LICENSE file for more info.
