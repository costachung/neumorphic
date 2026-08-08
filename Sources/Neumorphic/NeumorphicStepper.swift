import SwiftUI

/// A compact stepper with neumorphic decrement and increment buttons.
public struct NeumorphicStepper: View {
    @Binding private var value: Int
    private let bounds: ClosedRange<Int>
    private let label: String

    public init(_ label: String = "Value", value: Binding<Int>, in bounds: ClosedRange<Int> = 0...100) {
        self.label = label
        self._value = value
        self.bounds = bounds.lowerBound...max(bounds.lowerBound, bounds.upperBound)
    }

    public var body: some View {
        HStack(spacing: 12) {
            Button { value = max(bounds.lowerBound, value - 1) } label: { Text("−").font(.body.weight(.semibold)) }
                .buttonStyle(SoftDynamicButtonStyle(Circle(), mainColor: .Neumorphic.main, textColor: .Neumorphic.secondary, darkShadowColor: .Neumorphic.darkShadow, lightShadowColor: .Neumorphic.lightShadow, pressedEffect: .hard, padding: 10))
                .disabled(value <= bounds.lowerBound)
            Text("\(label): \(value)").frame(minWidth: 72)
            Button { value = min(bounds.upperBound, value + 1) } label: { Text("+").font(.body.weight(.semibold)) }
                .buttonStyle(SoftDynamicButtonStyle(Circle(), mainColor: .Neumorphic.main, textColor: .Neumorphic.secondary, darkShadowColor: .Neumorphic.darkShadow, lightShadowColor: .Neumorphic.lightShadow, pressedEffect: .hard, padding: 10))
                .disabled(value >= bounds.upperBound)
        }
        .foregroundColor(.Neumorphic.secondary)
    }
}
