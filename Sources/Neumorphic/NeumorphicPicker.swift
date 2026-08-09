import SwiftUI

/// A compact segmented picker for a small set of hashable options.
public struct NeumorphicPicker<Selection: Hashable>: View {
    @Environment(\.neumorphicTheme) private var theme
    @Binding private var selection: Selection
    private let options: [Selection]
    private let label: (Selection) -> String

    /// Creates a segmented neumorphic picker.
    ///
    /// - Parameters:
    ///   - selection: A binding to the selected value.
    ///   - options: The values displayed by the picker.
    ///   - label: A closure that provides display and accessibility text for each value.
    public init(
        selection: Binding<Selection>, options: [Selection],
        label: @escaping (Selection) -> String = { String(describing: $0) }
    ) {
        self._selection = selection
        self.options = options
        self.label = label
    }

    /// The rendered segmented picker.
    public var body: some View {
        HStack(spacing: 8) {
            ForEach(options, id: \.self) { option in
                Button {
                    selection = option
                } label: {
                    Text(label(option)).font(.subheadline.weight(.medium)).multilineTextAlignment(.center).frame(
                        maxWidth: .infinity, minHeight: 44)
                }
                .buttonStyle(
                    SoftDynamicButtonStyle(
                        Capsule(), mainColor: theme.mainColor, textColor: theme.secondaryColor,
                        darkShadowColor: theme.darkShadowColor, lightShadowColor: theme.lightShadowColor,
                        pressedEffect: selection == option ? .flat : .none, padding: 10)
                )
                .opacity(selection == option ? 1 : 0.75)
                .neumorphicSelectionAccessibility(label: label(option), selected: selection == option)
            }
        }
    }
}
