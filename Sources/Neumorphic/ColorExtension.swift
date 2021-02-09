import SwiftUI

public extension Color {
    struct Neumorphic {
        private static let defaultMainColor = UIColor(red: 0.925, green: 0.941, blue: 0.953, alpha: 1.000)
        private static let defaultSecondaryColor = UIColor(red: 0.482, green: 0.502, blue: 0.549, alpha: 1.000)
        private static let defaultLightShadowSolidColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        private static let defaultDarkShadowSolidColor = UIColor(red: 0.820, green: 0.851, blue: 0.902, alpha: 1.000)
        private static let defaultLightShadowColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.500)
        private static let defaultDarkShadowColor = UIColor(red: 0.66, green: 0.72, blue: 0.84, alpha: 0.55)

        private static let darkThemeMainColor = UIColor(red: 0.188, green: 0.192, blue: 0.208, alpha: 1.000)
        private static let darkThemeSecondaryColor = UIColor(red: 0.910, green: 0.910, blue: 0.910, alpha: 1.000)
        private static let darkThemeLightShadowSolidColor = UIColor(red: 0.243, green: 0.247, blue: 0.275, alpha: 1.000)
        private static let darkThemeDarkShadowSolidColor = UIColor(red: 0.137, green: 0.137, blue: 0.137, alpha: 1.000)
        private static let darkThemeLightShadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        private static let darkThemeDarkShadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        public static var main: Color {
            Color(.init { $0.userInterfaceStyle == .light ? Self.defaultMainColor : Self.darkThemeMainColor })
        }
        
        public static var secondary: Color {
            Color(.init { $0.userInterfaceStyle == .light ? Self.defaultSecondaryColor : Self.darkThemeSecondaryColor })
        }
        
        public static var lightShadow: Color {
            Color(.init { $0.userInterfaceStyle == .light ? Self.defaultLightShadowSolidColor : Self.darkThemeLightShadowSolidColor })
        }
        
        public static var darkShadow: Color {
            Color(.init { $0.userInterfaceStyle == .light ? Self.defaultDarkShadowSolidColor : Self.darkThemeDarkShadowSolidColor })
        }
    }
}
