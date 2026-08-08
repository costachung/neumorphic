import SwiftUI

/// A circular progress indicator with an inset track.
public struct NeumorphicCircularProgressView: View {
    private let value: Double?
    private let total: Double
    private let tint: Color
    private let diameter: CGFloat
    private let accessibilityLabel: String

    public init(value: Double?, total: Double = 1, tint: Color = .accentColor, diameter: CGFloat = 52, accessibilityLabel: String = "Progress") {
        self.value = value
        self.total = max(total, 0)
        self.tint = tint
        self.diameter = max(diameter, 24)
        self.accessibilityLabel = accessibilityLabel
    }

    public var body: some View {
        let fraction = value.map { min(max(total > 0 ? $0 / total : 0, 0), 1) }
        ZStack {
            Circle().stroke(Color.Neumorphic.main, lineWidth: 9).softInnerShadow(Circle(), spread: 0.5, radius: 3)
            Circle().trim(from: 0, to: CGFloat(fraction ?? 0.3)).stroke(tint, style: StrokeStyle(lineWidth: 7, lineCap: .round)).rotationEffect(.degrees(-90))
        }
        .frame(width: diameter, height: diameter)
        .neumorphicProgressAccessibility(label: accessibilityLabel, value: value.map { String(format: "%.0f%%", ($0 / max(total, 1)) * 100) } ?? "In progress")
    }
}
