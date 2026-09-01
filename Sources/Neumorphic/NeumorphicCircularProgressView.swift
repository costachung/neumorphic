import SwiftUI

/// A circular progress indicator with an inset track. 
public struct NeumorphicCircularProgressView: View {
    @Environment(\.neumorphicTheme) private var theme
    private let value: Double?
    private let total: Double
    private let tint: Color
    private let diameter: CGFloat
    private let accessibilityLabel: Text

    /// Creates a circular progress indicator.
    ///
    /// - Parameters:
    ///   - value: The completed amount, or `nil` to display an indeterminate indicator.
    ///   - total: The amount that represents completion. Negative values are normalized to zero.
    ///   - tint: The color of the progress arc.
    ///   - diameter: The indicator diameter. Values below 24 points are normalized to 24.
    public init(
        value: Double?, total: Double = 1, tint: Color = .accentColor, diameter: CGFloat = 52,
    ) {
        self.init(
            value: value,
            total: total,
            tint: tint,
            diameter: diameter,
            accessibilityLabel: Text(LocalizedStringKey("Progress"))
        )
    }

    /// Creates a circular progress indicator with an explicit accessibility label.
    ///
    /// - Parameters:
    ///   - value: The completed amount, or `nil` to display an indeterminate indicator.
    ///   - total: The amount that represents completion. Negative values are normalized to zero.
    ///   - tint: The color of the progress arc.
    ///   - diameter: The indicator diameter. Values below 24 points are normalized to 24.
    ///   - accessibilityLabel: The label VoiceOver announces for the control.
    public init(
        value: Double?, total: Double = 1, tint: Color = .accentColor, diameter: CGFloat = 52,
        accessibilityLabel: String = "Progress"
    ) {
        self.value = value
        self.total = max(total, 0)
        self.tint = tint
        self.diameter = max(diameter, 24)
        self.accessibilityLabel = Text(verbatim: accessibilityLabel)
    }

    private init(value: Double?, total: Double, tint: Color, diameter: CGFloat, accessibilityLabel: Text) {
        self.value = value
        self.total = max(total, 0)
        self.tint = tint
        self.diameter = max(diameter, 24)
        self.accessibilityLabel = accessibilityLabel
    }

    /// The rendered circular progress indicator.
    public var body: some View {
        let fraction = NeumorphicProgressMath.normalizedFraction(value: value, total: total)
        ZStack {
            Circle()
                .stroke(theme.mainColor, lineWidth: 9)
                .softInnerShadow(
                    Circle(),
                    darkShadow: theme.darkShadowColor,
                    lightShadow: theme.lightShadowColor,
                    spread: 0.5,
                    radius: 3
                )
            if let fraction = fraction {
                Circle()
                    .trim(from: 0, to: CGFloat(fraction))
                    .stroke(tint, style: StrokeStyle(lineWidth: 7, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            } else {
                NeumorphicCircularIndeterminateIndicator(tint: tint)
            }
        }
        .frame(width: diameter, height: diameter)
        .neumorphicProgressAccessibility(
            label: accessibilityLabel,
            value: fraction.map { Text(verbatim: String(format: "%.0f%%", $0 * 100)) }
                ?? Text(LocalizedStringKey("In progress"))
        )
    }
}

private struct NeumorphicCircularIndeterminateIndicator: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isAnimating = false

    let tint: Color

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.3)
            .stroke(tint, style: StrokeStyle(lineWidth: 7, lineCap: .round))
            .rotationEffect(.degrees(reduceMotion ? -90 : (isAnimating ? 270 : -90)))
            .opacity(reduceMotion ? 0.7 : 1)
            .onAppear {
                guard !reduceMotion else { return }
                withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
    }
}
