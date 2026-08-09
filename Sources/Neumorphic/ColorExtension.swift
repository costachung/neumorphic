import SwiftUI

public extension Color {

    /// Default colors used by Neumorphic controls and modifiers.
    struct Neumorphic {
        //Color
        private static let defaultMainColor = NeumorphicKit.colorType(red: 0.925, green: 0.941, blue: 0.953)
        // Keep the default text/accent color above WCAG AA contrast on the light surface.
        private static let defaultSecondaryColor = NeumorphicKit.colorType(red: 0.350, green: 0.370, blue: 0.420)
        private static let defaultLightShadowSolidColor = NeumorphicKit.colorType(red: 1.000, green: 1.000, blue: 1.000)
        private static let defaultDarkShadowSolidColor = NeumorphicKit.colorType(red: 0.820, green: 0.851, blue: 0.902)

        private static let darkThemeMainColor = NeumorphicKit.colorType(red: 0.188, green: 0.192, blue: 0.208)
        private static let darkThemeSecondaryColor = NeumorphicKit.colorType(red: 0.910, green: 0.910, blue: 0.910)
        private static let darkThemeLightShadowSolidColor = NeumorphicKit.colorType(
            red: 0.243, green: 0.247, blue: 0.275)
        private static let darkThemeDarkShadowSolidColor = NeumorphicKit.colorType(
            red: 0.137, green: 0.137, blue: 0.137)

        /// Gets or sets the global default color appearance.
        public static var colorSchemeType: NeumorphicKit.ColorSchemeType {
            get {
                return NeumorphicKit.colorSchemeType
            }
            set {
                NeumorphicKit.colorSchemeType = newValue
            }
        }

        /// The default surface color.
        public static var main: Color {
            NeumorphicKit.color(light: defaultMainColor, dark: darkThemeMainColor)
        }

        /// The default text and accent color.
        public static var secondary: Color {
            NeumorphicKit.color(light: defaultSecondaryColor, dark: darkThemeSecondaryColor)
        }

        /// The default light shadow color.
        public static var lightShadow: Color {
            NeumorphicKit.color(light: defaultLightShadowSolidColor, dark: darkThemeLightShadowSolidColor)
        }

        /// The default dark shadow color.
        public static var darkShadow: Color {
            NeumorphicKit.color(light: defaultDarkShadowSolidColor, dark: darkThemeDarkShadowSolidColor)
        }
    }

}
