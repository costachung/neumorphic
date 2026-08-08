import SwiftUI

/// A neumorphic slider with an inset track and raised thumb.
public struct NeumorphicSlider: View {
    @Binding private var value: Double
    private let bounds: ClosedRange<Double>
    private let step: Double
    private let tint: Color
    private let onEditingChanged: (Bool) -> Void

    public init(value: Binding<Double>, in bounds: ClosedRange<Double> = 0...1, step: Double = 0, tint: Color = .accentColor, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self._value = value
        self.bounds = bounds
        self.step = max(step, 0)
        self.tint = tint
        self.onEditingChanged = onEditingChanged
    }

    public var body: some View {
        GeometryReader { proxy in
            let width = max(proxy.size.width, 1)
            let progress = normalizedValue
            ZStack(alignment: .leading) {
                Capsule().fill(Color.Neumorphic.main).softInnerShadow(Capsule(), spread: 0.5, radius: 3)
                Capsule().fill(tint.opacity(0.8)).frame(width: max(0, width * progress), height: 6)
                Circle().fill(Color.Neumorphic.main).frame(width: 28, height: 28)
                    .softOuterShadow(offset: 3, radius: 2)
                    .overlay(Circle().fill(tint).frame(width: 10, height: 10))
                    .offset(x: max(0, min(width - 28, width * progress - 14)))
            }
            .frame(height: 28)
            .contentShape(Rectangle())
            .gesture(DragGesture(minimumDistance: 0).onChanged { gesture in
                onEditingChanged(true)
                updateValue(at: gesture.location.x, width: width)
            }.onEnded { _ in onEditingChanged(false) })
        }
        .frame(minHeight: 32)
    }

    private var normalizedValue: CGFloat {
        guard bounds.upperBound > bounds.lowerBound else { return 0 }
        return CGFloat((min(max(value, bounds.lowerBound), bounds.upperBound) - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound))
    }

    private func updateValue(at x: CGFloat, width: CGFloat) {
        let raw = bounds.lowerBound + (bounds.upperBound - bounds.lowerBound) * Double(min(max(x / width, 0), 1))
        value = step > 0 ? min(bounds.upperBound, max(bounds.lowerBound, (raw / step).rounded() * step)) : raw
    }
}
