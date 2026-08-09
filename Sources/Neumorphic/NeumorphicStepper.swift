import SwiftUI

/// A compact stepper with neumorphic decrement and increment buttons.
public struct NeumorphicStepper: View {
    @Environment(\.neumorphicTheme) private var theme
    @Binding private var value: Int
    private let bounds: ClosedRange<Int>
    private let label: String

    /// Creates a stepper that changes an integer by one per activation.
    ///
    /// - Parameters:
    ///   - label: The text that describes the value.
    ///   - value: A binding to the current value.
    ///   - bounds: The limits applied by the decrement and increment buttons.
    public init(_ label: String = "Value", value: Binding<Int>, in bounds: ClosedRange<Int> = 0...100) {
        self.label = label
        self._value = value
        self.bounds = bounds.lowerBound...max(bounds.lowerBound, bounds.upperBound)
    }

    /// The rendered stepper.
    public var body: some View {
        HStack(spacing: 12) {
            Button {
                value = max(bounds.lowerBound, value - 1)
            } label: {
                Text("−").font(.body.weight(.semibold)).frame(minWidth: 44, minHeight: 44)
            }
            .buttonStyle(
                SoftDynamicButtonStyle(
                    Circle(), mainColor: theme.mainColor, textColor: theme.secondaryColor,
                    darkShadowColor: theme.darkShadowColor, lightShadowColor: theme.lightShadowColor,
                    pressedEffect: .hard, padding: 10)
            )
            .disabled(value <= bounds.lowerBound)
            .neumorphicButtonAccessibility(
                label: Text(LocalizedStringKey("Decrease")) + Text(" ") + Text(verbatim: label)
            )
            Text("\(label): \(value)").frame(minWidth: 72)
            Button {
                value = min(bounds.upperBound, value + 1)
            } label: {
                Text("+").font(.body.weight(.semibold)).frame(minWidth: 44, minHeight: 44)
            }
            .buttonStyle(
                SoftDynamicButtonStyle(
                    Circle(), mainColor: theme.mainColor, textColor: theme.secondaryColor,
                    darkShadowColor: theme.darkShadowColor, lightShadowColor: theme.lightShadowColor,
                    pressedEffect: .hard, padding: 10)
            )
            .disabled(value >= bounds.upperBound)
            .neumorphicButtonAccessibility(
                label: Text(LocalizedStringKey("Increase")) + Text(" ") + Text(verbatim: label)
            )
        }
        .foregroundColor(theme.secondaryColor)
    }
}
