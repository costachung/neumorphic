import SwiftUI

/// The semantic color role of a themed neumorphic button.
public enum NeumorphicButtonRole: Sendable {
    /// Uses the theme's surface and foreground colors.
    case surface
    /// Uses the theme's accent and on-accent colors.
    case accent
}

/// A group of colors used by Neumorphic controls.
public struct NeumorphicTheme: @unchecked Sendable {
    /// The surface color used by controls and containers.
    public let mainColor: Color
    /// The foreground color used by labels and symbols.
    public let secondaryColor: Color
    /// The surface color used by emphasized controls.
    public let accentColor: Color
    /// The foreground color used on emphasized controls.
    public let onAccentColor: Color
    /// The shadow color applied toward the lower-right edge of raised surfaces.
    public let darkShadowColor: Color
    /// The highlight color applied toward the upper-left edge of raised surfaces.
    public let lightShadowColor: Color

    /// Creates a theme from surface, foreground, and shadow colors.
    ///
    /// - Parameters:
    ///   - mainColor: The surface color used by controls and containers.
    ///   - secondaryColor: The foreground color used by labels and symbols.
    ///   - darkShadowColor: The darker shadow color for raised and inset surfaces.
    ///   - lightShadowColor: The lighter highlight color for raised and inset surfaces.
    public init(
        mainColor: Color,
        secondaryColor: Color,
        darkShadowColor: Color,
        lightShadowColor: Color
    ) {
        self.init(
            mainColor: mainColor,
            secondaryColor: secondaryColor,
            accentColor: secondaryColor,
            onAccentColor: mainColor,
            darkShadowColor: darkShadowColor,
            lightShadowColor: lightShadowColor
        )
    }

    /// Creates a theme with separate colors for surface and emphasized controls.
    ///
    /// - Parameters:
    ///   - mainColor: The surface color used by controls and containers.
    ///   - secondaryColor: The foreground color used by labels and symbols.
    ///   - accentColor: The surface color used by emphasized controls.
    ///   - onAccentColor: The foreground color used on emphasized controls.
    ///   - darkShadowColor: The darker shadow color for raised and inset surfaces.
    ///   - lightShadowColor: The lighter highlight color for raised and inset surfaces.
    public init(
        mainColor: Color,
        secondaryColor: Color,
        accentColor: Color,
        onAccentColor: Color,
        darkShadowColor: Color,
        lightShadowColor: Color
    ) {
        self.mainColor = mainColor
        self.secondaryColor = secondaryColor
        self.accentColor = accentColor
        self.onAccentColor = onAccentColor
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
    }

    /// The default theme matching `Color.Neumorphic`.
    public static let standard = NeumorphicTheme(
        mainColor: .Neumorphic.main,
        secondaryColor: .Neumorphic.secondary,
        accentColor: .Neumorphic.secondary,
        onAccentColor: .Neumorphic.main,
        darkShadowColor: .Neumorphic.darkShadow,
        lightShadowColor: .Neumorphic.lightShadow
    )

    /// A higher-contrast theme for low-vision and demonstration scenarios.
    public static let highContrast = NeumorphicTheme(
        mainColor: Color(red: 0.88, green: 0.90, blue: 0.93),
        secondaryColor: Color(red: 0.08, green: 0.09, blue: 0.12),
        accentColor: Color(red: 0.08, green: 0.09, blue: 0.12),
        onAccentColor: Color(red: 0.88, green: 0.90, blue: 0.93),
        darkShadowColor: Color(red: 0.55, green: 0.58, blue: 0.65),
        lightShadowColor: .white
    )

    func resolvedButtonColors(for role: NeumorphicButtonRole) -> (surface: Color, foreground: Color) {
        switch role {
        case .surface:
            return (mainColor, secondaryColor)
        case .accent:
            return (accentColor, onAccentColor)
        }
    }
}

/// Tunable shadow parameters for balancing depth and rendering cost.
public struct NeumorphicShadowPreset: @unchecked Sendable {
    private enum ColorSource: Sendable {
        case explicit
        case theme(opacity: Double)
    }

    /// The darker color used by the shadow.
    public let darkShadowColor: Color
    /// The lighter color used by the shadow.
    public let lightShadowColor: Color
    /// The distance of an outer shadow from its surface, normalized to a nonnegative value.
    public let offset: CGFloat
    /// The shadow blur radius, normalized to a nonnegative value.
    public let radius: CGFloat
    /// The inset shadow spread, normalized to the closed range from zero through one.
    public let spread: CGFloat
    private let colorSource: ColorSource

    /// Creates a shadow preset with explicit colors and geometry.
    ///
    /// Custom presets retain these colors when a different environment theme is applied.
    ///
    /// - Parameters:
    ///   - darkShadowColor: The darker color used by the shadow.
    ///   - lightShadowColor: The lighter color used by the shadow.
    ///   - offset: The outer-shadow offset. Negative values are normalized to zero.
    ///   - radius: The blur radius. Negative values are normalized to zero.
    ///   - spread: The inset-shadow spread. Values are clamped to the closed range from zero through one.
    public init(
        darkShadowColor: Color,
        lightShadowColor: Color,
        offset: CGFloat = 6,
        radius: CGFloat = 3,
        spread: CGFloat = 0.5
    ) {
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.offset = max(offset, 0)
        self.radius = max(radius, 0)
        self.spread = min(max(spread, 0), 1)
        self.colorSource = .explicit
    }

    /// The standard shadow geometry, resolving its colors from the current environment theme when applied as a preset.
    public static let standard = NeumorphicShadowPreset(
        darkShadowColor: .Neumorphic.darkShadow,
        lightShadowColor: .Neumorphic.lightShadow,
        colorSource: .theme(opacity: 1)
    )

    /// A lower-cost preset for dense scrolling content, resolving its colors from the current environment theme.
    public static let subtle = NeumorphicShadowPreset(
        darkShadowColor: .Neumorphic.darkShadow.opacity(0.65),
        lightShadowColor: .Neumorphic.lightShadow.opacity(0.65),
        offset: 3,
        radius: 2,
        spread: 0.35,
        colorSource: .theme(opacity: 0.65)
    )

    /// Removes shadow layers while retaining the surface itself.
    public static let none = NeumorphicShadowPreset(
        darkShadowColor: .clear,
        lightShadowColor: .clear,
        offset: 0,
        radius: 0,
        spread: 0
    )

    private init(
        darkShadowColor: Color,
        lightShadowColor: Color,
        offset: CGFloat = 6,
        radius: CGFloat = 3,
        spread: CGFloat = 0.5,
        colorSource: ColorSource
    ) {
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.offset = max(offset, 0)
        self.radius = max(radius, 0)
        self.spread = min(max(spread, 0), 1)
        self.colorSource = colorSource
    }

    func resolvedShadowColors(for theme: NeumorphicTheme) -> (dark: Color, light: Color) {
        switch colorSource {
        case .explicit:
            return (darkShadowColor, lightShadowColor)
        case .theme(let opacity):
            return (
                theme.darkShadowColor.opacity(opacity),
                theme.lightShadowColor.opacity(opacity)
            )
        }
    }
}

private struct NeumorphicThemeKey: EnvironmentKey {
    static let defaultValue = NeumorphicTheme.standard
}

public extension EnvironmentValues {
    /// The theme used by Neumorphic controls and explicit themed modifiers.
    var neumorphicTheme: NeumorphicTheme {
        get { self[NeumorphicThemeKey.self] }
        set { self[NeumorphicThemeKey.self] = newValue }
    }
}

public extension View {
    /// Provides a theme to Neumorphic controls and themed modifiers below this view.
    func neumorphicTheme(_ theme: NeumorphicTheme) -> some View {
        environment(\.neumorphicTheme, theme)
    }

    /// Applies a button style using the current environment theme.
    ///
    /// - Parameters:
    ///   - shape: The shape of the surface.
    ///   - padding: The inset between the label and the surface edge.
    ///   - pressedEffect: The visual treatment applied while the control is pressed.
    func neumorphicThemedButtonStyle<S: Shape>(
        _ shape: S,
        padding: CGFloat = 16,
        pressedEffect: SoftButtonPressedEffect = .hard
    ) -> some View {
        neumorphicThemedButtonStyle(
            shape,
            role: .surface,
            padding: padding,
            pressedEffect: pressedEffect
        )
    }

    /// Applies a semantic button style using the current environment theme.
    ///
    /// - Parameters:
    ///   - shape: The shape of the surface.
    ///   - role: The semantic color role of the button.
    ///   - padding: The inset between the label and the surface edge.
    ///   - pressedEffect: The visual treatment applied while the control is pressed.
    func neumorphicThemedButtonStyle<S: Shape>(
        _ shape: S,
        role: NeumorphicButtonRole,
        padding: CGFloat = 16,
        pressedEffect: SoftButtonPressedEffect = .hard
    ) -> some View {
        modifier(
            NeumorphicThemedButtonModifier(
                shape: shape,
                role: role,
                padding: padding,
                pressedEffect: pressedEffect
            )
        )
    }

    /// Applies a shape-based toggle style using the current environment theme.
    ///
    /// - Parameters:
    ///   - shape: The shape of the surface.
    ///   - padding: The inset between the label and the surface edge.
    ///   - pressedEffect: The visual treatment applied while the control is pressed.
    func neumorphicThemedToggleStyle<S: Shape>(
        _ shape: S,
        padding: CGFloat = 16,
        pressedEffect: SoftButtonPressedEffect = .hard
    ) -> some View {
        modifier(NeumorphicThemedToggleModifier(shape: shape, padding: padding, pressedEffect: pressedEffect))
    }

    /// Applies a switch style using the current environment theme.
    ///
    /// - Parameters:
    ///   - tint: The track color while the control is on.
    ///   - labelsHidden: A Boolean value that hides the label when `true`.
    ///   - height: The control height in points. Values below 1 are normalized to 1.
    func neumorphicThemedSwitchStyle(
        tint: Color = .green,
        labelsHidden: Bool = false,
        height: CGFloat = 30
    ) -> some View {
        modifier(NeumorphicThemedSwitchModifier(tint: tint, labelsHidden: labelsHidden, height: height))
    }
}

private struct NeumorphicThemedButtonModifier<S: Shape>: ViewModifier {
    @Environment(\.neumorphicTheme) private var theme
    let shape: S
    let role: NeumorphicButtonRole
    let padding: CGFloat
    let pressedEffect: SoftButtonPressedEffect

    func body(content: Content) -> some View {
        let colors = theme.resolvedButtonColors(for: role)
        content.softButtonStyle(
            shape,
            padding: padding,
            mainColor: colors.surface,
            textColor: colors.foreground,
            darkShadowColor: theme.darkShadowColor,
            lightShadowColor: theme.lightShadowColor,
            pressedEffect: pressedEffect
        )
    }
}

private struct NeumorphicThemedToggleModifier<S: Shape>: ViewModifier {
    @Environment(\.neumorphicTheme) private var theme
    let shape: S
    let padding: CGFloat
    let pressedEffect: SoftButtonPressedEffect

    func body(content: Content) -> some View {
        content.softToggleStyle(
            shape,
            padding: padding,
            mainColor: theme.mainColor,
            textColor: theme.secondaryColor,
            darkShadowColor: theme.darkShadowColor,
            lightShadowColor: theme.lightShadowColor,
            pressedEffect: pressedEffect
        )
    }
}

private struct NeumorphicThemedSwitchModifier: ViewModifier {
    @Environment(\.neumorphicTheme) private var theme
    let tint: Color
    let labelsHidden: Bool
    let height: CGFloat

    func body(content: Content) -> some View {
        content.switchToggleStyle(
            tint: tint,
            offTint: theme.mainColor,
            mainColor: theme.mainColor,
            darkShadowColor: theme.darkShadowColor,
            lightShadowColor: theme.lightShadowColor,
            labelsHidden: labelsHidden,
            height: height
        )
    }
}
