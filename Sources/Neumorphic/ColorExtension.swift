
import SwiftUI

public extension Color {

	struct Neumorphic {
		
		private static var isDarkMode:Bool {
			#if os(iOS)
			return UITraitCollection.current.userInterfaceStyle == .dark
			#else
			if let window = NSApp.mainWindow {
				return window.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
			}
			return NSAppearance.current.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
			#endif
		}
		
		
		//Color
		public static let defaultMainColor = Color(red: 0.925, green: 0.941, blue: 0.953, opacity: 1.000)
		public static let defaultSecondaryColor = Color(red: 0.482, green: 0.502, blue: 0.549, opacity: 1.000)
		public static let defaultLightShadowSolidColor = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 1.000)
		public static let defaultDarkShadowSolidColor = Color(red: 0.820, green: 0.851, blue: 0.902, opacity: 1.000)

		public static let darkThemeMainColor = Color(red: 0.188, green: 0.192, blue: 0.208, opacity: 1.000)
		public static let darkThemeSecondaryColor = Color(red: 0.910, green: 0.910, blue: 0.910, opacity: 1.000)
		public static let darkThemeLightShadowSolidColor = Color(red: 0.243, green: 0.247, blue: 0.275, opacity: 1.000)
		public static let darkThemeDarkShadowSolidColor = Color(red: 0.137, green: 0.137, blue: 0.137, opacity: 1.000)
				
		public static var main: Color {
			isDarkMode ? darkThemeMainColor : defaultMainColor
		}
		
		public static var secondary: Color {
			isDarkMode ? darkThemeSecondaryColor : defaultSecondaryColor
		}

		public static var lightShadow: Color {
			isDarkMode ? darkThemeLightShadowSolidColor : defaultLightShadowSolidColor
		}

		public static var darkShadow: Color {
			isDarkMode ? darkThemeDarkShadowSolidColor : defaultDarkShadowSolidColor
		}
	}
}
