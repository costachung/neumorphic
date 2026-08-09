import SwiftUI

/// Adds a subtle pointer-hover outline on macOS while remaining a no-op on iOS.
public struct NeumorphicHoverEffect<S: Shape>: ViewModifier {
    @Binding private var isHovered: Bool
    private let shape: S
    private let color: Color
    private let lineWidth: CGFloat

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

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
    func neumorphicHover<S: Shape>(
        _ shape: S,
        isHovered: Binding<Bool>,
        color: Color = .accentColor,
        lineWidth: CGFloat = 1.5
    ) -> some View {
        modifier(NeumorphicHoverEffect(shape, isHovered: isHovered, color: color, lineWidth: lineWidth))
    }
}
