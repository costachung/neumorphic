import SwiftUI

/// Adds an explicit, keyboard- and accessibility-friendly focus indicator.
public struct NeumorphicFocusRing<S: Shape>: ViewModifier {
    @Binding private var isFocused: Bool
    private let shape: S
    private let color: Color
    private let lineWidth: CGFloat

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

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
    func neumorphicFocusRing<S: Shape>(
        _ shape: S,
        isFocused: Binding<Bool>,
        color: Color = .accentColor,
        lineWidth: CGFloat = 2
    ) -> some View {
        modifier(NeumorphicFocusRing(shape, isFocused: isFocused, color: color, lineWidth: lineWidth))
    }
}
