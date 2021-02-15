public enum ColorSchemeType {
    case auto, light, dark
}

/// By Setting this variable to .light or .dark, the colorSheme can be forced.
/// Additionally, it can be used to switch between colorSchemes manually
/// (only recommended for OSX). Default = .auto
public var neumorphicColorScheme = ColorSchemeType.auto
