import SwiftUI

public extension Color {

    struct Neumorphic {
        #if os(macOS)
        private typealias ColorType = Color
        private static func colorType(red: Double, green: Double, blue: Double) -> ColorType {
            .init(red: red, green: green, blue: blue, opacity: 1.0)
        }
        
        private static func isDarkMode() -> Bool {
            if let window = NSApp.mainWindow {
                return window.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
            }
            return NSAppearance.current.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
        }
        #else
        private typealias ColorType = UIColor
        private static func colorType(red: CGFloat, green: CGFloat, blue: CGFloat) -> ColorType {
            .init(red: red, green: green, blue: blue, alpha: 1.0)
        }
        #endif
        
        private static func color(light: ColorType, dark: ColorType) -> Color {
            #if os(iOS)
            switch neumorphicColorScheme {
            case .light:
                return Color(light)
            case .dark:
                return Color(dark)
            case .auto:
                return Color(.init { $0.userInterfaceStyle == .light ? light : dark })
            }
            #else
            switch neumorphicColorScheme {
            case .light:
                return light
            case .dark:
                return dark
            case .auto:
                return isDarkMode() ? dark : light
            }
            #endif
        }
        
        //Color
        private static let defaultMainColor = colorType(red: 0.925, green: 0.941, blue: 0.953)
        private static let defaultSecondaryColor = colorType(red: 0.482, green: 0.502, blue: 0.549)
        private static let defaultLightShadowSolidColor = colorType(red: 1.000, green: 1.000, blue: 1.000)
        private static let defaultDarkShadowSolidColor = colorType(red: 0.820, green: 0.851, blue: 0.902)

        private static let darkThemeMainColor = colorType(red: 0.188, green: 0.192, blue: 0.208)
        private static let darkThemeSecondaryColor = colorType(red: 0.910, green: 0.910, blue: 0.910)
        private static let darkThemeLightShadowSolidColor = colorType(red: 0.243, green: 0.247, blue: 0.275)
        private static let darkThemeDarkShadowSolidColor = colorType(red: 0.137, green: 0.137, blue: 0.137)
                
        public static var main: Color {
            color(light: defaultMainColor, dark: darkThemeMainColor)
        }
        
        public static var secondary: Color {
            color(light: defaultSecondaryColor, dark: darkThemeSecondaryColor)
        }

        public static var lightShadow: Color {
            color(light: defaultLightShadowSolidColor, dark: darkThemeLightShadowSolidColor)
        }

        public static var darkShadow: Color {
            color(light: defaultDarkShadowSolidColor, dark: darkThemeDarkShadowSolidColor)
        }
    }
}
