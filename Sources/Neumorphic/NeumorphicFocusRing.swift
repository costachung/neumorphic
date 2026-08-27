import SwiftUI

/// Adds an explicit, keyboard- and accessibility-friendly focus indicator.
public struct NeumorphicFocusRing<S: Shape>: ViewModifier {
    @Binding private var isFocused: Bool
    private let shape: S
    private let color: Color
    private let lineWidth: CGFloat

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// Creates a focus ring for the supplied shape.
    ///
    /// - Parameters:
    ///   - shape: The shape the ring is stroked along.
    ///   - isFocused: Drives ring visibility; bind it to your own focus state.
    ///   - color: The ring color. Defaults to the accent color.
    ///   - lineWidth: The ring thickness in points. Clamped to a minimum of 1.
    public init(
        _ shape: S,
        isFocused: Binding<Bool>,
        color: Color = .accentColor,
        lineWidth: CGFloat = 2
    ) {
        self.shape = shape
        self._isFocused = isFocused
        self.color = color
        self.lineWidth = max(lineWidth, 1)
    }

    /// Overlays the focus ring, animating it unless Reduce Motion is on.
    public func body(content: Content) -> some View {
        content.overlay(
            shape
                .stroke(isFocused ? color : .clear, lineWidth: lineWidth)
                .padding(-lineWidth)
                .animation(reduceMotion ? nil : .easeInOut(duration: 0.15), value: isFocused)
        )
    }
}

public extension View {
    /// Applies an explicit focus ring to a control.
    ///
    /// - Parameters:
    ///   - shape: The shape of the surface.
    ///   - isFocused: Drives ring visibility; bind it to your own focus state.
    ///   - color: The stroke color. Defaults to the accent color.
    ///   - lineWidth: The stroke thickness in points. Clamped to a minimum of 1.
    func neumorphicFocusRing<S: Shape>(
        _ shape: S,
        isFocused: Binding<Bool>,
        color: Color = .accentColor,
        lineWidth: CGFloat = 2
    ) -> some View {
        modifier(NeumorphicFocusRing(shape, isFocused: isFocused, color: color, lineWidth: lineWidth))
    }
}
