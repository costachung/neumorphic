import SwiftUI

/// Applies a raised neumorphic card surface to any view.
public extension View {
    /// Applies a card using the current theme and supplied shadow preset.
    func neumorphicCard<S: Shape>(
        _ shape: S = RoundedRectangle(cornerRadius: 16, style: .continuous),
        padding: CGFloat = 16,
        preset: NeumorphicShadowPreset = .standard
    ) -> some View {
        modifier(NeumorphicCardModifier(shape: shape, padding: padding, preset: preset))
    }
}

private struct NeumorphicCardModifier<S: Shape>: ViewModifier {
    @Environment(\.neumorphicTheme) private var theme

    let shape: S
    let padding: CGFloat
    let preset: NeumorphicShadowPreset

    func body(content: Content) -> some View {
        let colors = preset.resolvedShadowColors(for: theme)
        content
            .padding(padding)
            .clipShape(shape)
            .background(
                shape
                    .fill(theme.mainColor)
                    .softOuterShadow(
                        darkShadow: colors.dark,
                        lightShadow: colors.light,
                        offset: preset.offset,
                        radius: preset.radius
                    )
            )
    }
}
