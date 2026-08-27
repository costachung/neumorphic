import SwiftUI

/// Adds a subtle pointer-hover outline on macOS while remaining a no-op on iOS.
public struct NeumorphicHoverEffect<S: Shape>: ViewModifier {
    @Binding private var isHovered: Bool
    private let shape: S
    private let color: Color
    private let lineWidth: CGFloat

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// Creates a hover outline for the supplied shape.
    ///
    /// - Parameters:
    ///   - shape: The shape the outline is stroked along.
    ///   - isHovered: Updated by the modifier on macOS; never written on iOS.
    ///   - color: The outline color. Defaults to the accent color.
    ///   - lineWidth: The outline thickness in points. Clamped to a minimum of 1.
    public init(
        _ shape: S,
        isHovered: Binding<Bool>,
        color: Color = .accentColor,
        lineWidth: CGFloat = 1.5
    ) {
        self.shape = shape
        self._isHovered = isHovered
        self.color = color
        self.lineWidth = max(lineWidth, 1)
    }

    /// Overlays the hover outline on macOS and returns the content unchanged elsewhere.
    public func body(content: Content) -> some View {
        #if os(macOS)
            content
                .onHover { hovering in isHovered = hovering }
                .overlay(
                    shape
                        .stroke(isHovered ? color : .clear, lineWidth: lineWidth)
                        .animation(reduceMotion ? nil : .easeInOut(duration: 0.15), value: isHovered)
                )
        #else
            content
        #endif
    }
}

public extension View {
    /// Applies a pointer-hover outline on macOS.
    ///
    /// - Parameters:
    ///   - shape: The shape of the surface.
    ///   - isHovered: Updated by the modifier on macOS; never written on iOS.
    ///   - color: The stroke color. Defaults to the accent color.
    ///   - lineWidth: The stroke thickness in points. Clamped to a minimum of 1.
    func neumorphicHover<S: Shape>(
        _ shape: S,
        isHovered: Binding<Bool>,
        color: Color = .accentColor,
        lineWidth: CGFloat = 1.5
    ) -> some View {
        modifier(NeumorphicHoverEffect(shape, isHovered: isHovered, color: color, lineWidth: lineWidth))
    }
}
