import SwiftUI

public extension Color {
	
	struct Neumorphic {
		
		public static var colorScheme:ColorScheme = .light
		
		private static let defaultMainColor = Color(red: 0.925, green: 0.941, blue: 0.953, opacity: 1.000)
		private static let defaultSecondaryColor = Color(red: 0.482, green: 0.502, blue: 0.549, opacity: 1.000)
		private static let defaultLightShadowSolidColor = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 1.000)
		private static let defaultdarkShadowSolidColor = Color(red: 0.820, green: 0.851, blue: 0.902, opacity: 1.000)
		private static let defaultLightShadowColor = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 0.500)
		private static let defaultdarkShadowColor = Color(red: 0.66, green: 0.72, blue: 0.84, opacity: 0.55)
		
		private static let darkThemeMainColor = Color(red: 0.188, green: 0.192, blue: 0.208, opacity: 1.000)
		private static let darkThemeSecondaryColor = Color(red: 0.910, green: 0.910, blue: 0.910, opacity: 1.000)
		private static let darkThemeLightShadowSolidColor = Color(red: 0.243, green: 0.247, blue: 0.275, opacity: 1.000)
		private static let darkThemedarkShadowSolidColor = Color(red: 0.137, green: 0.137, blue: 0.137, opacity: 1.000)
		private static let darkThemeLightShadowColor = Color(red: 1, green: 1, blue: 1, opacity: 0.1)
		private static let darkThemedarkShadowColor = Color(red: 0, green: 0, blue: 0, opacity: 0.5)
		
		
		public static var main: Color {
			colorScheme == .dark ? Self.darkThemeMainColor : Self.defaultMainColor
		}
		
		public static var secondary: Color {
			colorScheme == .dark ? Self.darkThemeSecondaryColor : Self.defaultSecondaryColor
		}
		
		public static var lightShadow: Color {
			colorScheme == .dark ? Self.darkThemeLightShadowSolidColor : Self.defaultLightShadowSolidColor
		}
		
		public static var darkShadow: Color {
			colorScheme == .dark ? Self.darkThemedarkShadowSolidColor : Self.defaultdarkShadowSolidColor
		}
		
	}
}
