import SwiftUI

public extension Color {

    struct Neumorphic {
        
        //Color
        private static let defaultMainColor = Color(red: 0.925, green: 0.941, blue: 0.953, opacity: 1.000)
        private static let defaultSecondaryColor = Color(red: 0.482, green: 0.502, blue: 0.549, opacity: 1.000)
        private static let defaultLightShadowSolidColor = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 1.000)
        private static let defaultDarkShadowSolidColor = Color(red: 0.820, green: 0.851, blue: 0.902, opacity: 1.000)
        private static let defaultLightShadowColor = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 0.500)
        private static let defaultDarkShadowColor = Color(red: 0.66, green: 0.72, blue: 0.84, opacity: 0.55)

        private static let darkThemeMainColor = Color(red: 0.188, green: 0.192, blue: 0.208, opacity: 1.000)
        private static let darkThemeSecondaryColor = Color(red: 0.910, green: 0.910, blue: 0.910, opacity: 1.000)
        private static let darkThemeLightShadowSolidColor = Color(red: 0.243, green: 0.247, blue: 0.275, opacity: 1.000)
        private static let darkThemeDarkShadowSolidColor = Color(red: 0.137, green: 0.137, blue: 0.137, opacity: 1.000)
        private static let darkThemeLightShadowColor = Color(red: 1, green: 1, blue: 1, opacity: 0.1)
        private static let darkThemeDarkShadowColor = Color(red: 0, green: 0, blue: 0, opacity: 0.5)
        
        //CGColor
        private static let defaultMainCGColor = CGColor(red: 0.925, green: 0.941, blue: 0.953, alpha: 1.000)
        private static let defaultSecondaryCGColor = CGColor(red: 0.482, green: 0.502, blue: 0.549, alpha: 1.000)
        private static let defaultLightShadowSolidCGColor = CGColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        private static let defaultDarkShadowSolidCGColor = CGColor(red: 0.820, green: 0.851, blue: 0.902, alpha: 1.000)
        private static let defaultLightShadowCGColor = CGColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.500)
        private static let defaultDarkShadowCGColor = CGColor(red: 0.66, green: 0.72, blue: 0.84, alpha: 0.55)

        private static let darkThemeMainCGColor = CGColor(red: 0.188, green: 0.192, blue: 0.208, alpha: 1.000)
        private static let darkThemeSecondaryCGColor = CGColor(red: 0.910, green: 0.910, blue: 0.910, alpha: 1.000)
        private static let darkThemeLightShadowSolidCGColor = CGColor(red: 0.243, green: 0.247, blue: 0.275, alpha: 1.000)
        private static let darkThemeDarkShadowSolidCGColor = CGColor(red: 0.137, green: 0.137, blue: 0.137, alpha: 1.000)
        private static let darkThemeLightShadowCGColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        private static let darkThemeDarkShadowCGColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)

        #if os(macOS)
        private static func isDarkMode() -> Bool {
            if let window = NSApp.mainWindow {
                return window.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
            }
            return NSAppearance.current.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
        }
        #endif
        
        public static var main: Color {
            #if os(iOS)
            return Color(.init { $0.userInterfaceStyle == .light ? UIColor(cgColor: defaultMainCGColor) : UIColor(cgColor: darkThemeMainCGColor) })
            #else
            return isDarkMode() ? darkThemeMainColor : defaultMainColor
            #endif
        }
        
        public static var secondary: Color {
            #if os(iOS)
            return Color(.init { $0.userInterfaceStyle == .light ? UIColor(cgColor: defaultSecondaryCGColor) : UIColor(cgColor: darkThemeSecondaryCGColor) })
            #else
            return isDarkMode() ? darkThemeSecondaryColor : defaultSecondaryColor
            #endif
        }

        public static var lightShadow: Color {
            #if os(iOS)
            return Color(.init { $0.userInterfaceStyle == .light ? UIColor(cgColor: defaultLightShadowSolidCGColor) : UIColor(cgColor: darkThemeLightShadowSolidCGColor) })
            #else
            return isDarkMode() ? darkThemeLightShadowSolidColor : defaultLightShadowSolidColor
            #endif
        }

        public static var darkShadow: Color {
            #if os(iOS)
            return Color(.init { $0.userInterfaceStyle == .light ? UIColor(cgColor: defaultDarkShadowSolidCGColor) : UIColor(cgColor: darkThemeDarkShadowSolidCGColor) })
            #else
            return isDarkMode() ? darkThemeDarkShadowColor : defaultDarkShadowSolidColor
            #endif
        }
    }
}
