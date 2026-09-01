import SwiftUI
 
/// A menu button with a raised neumorphic trigger surface.
@available(iOS 14.0, macOS 11.0, *)
public struct NeumorphicMenu<Selection: Hashable>: View {
    @Environment(\.neumorphicTheme) private var theme
    private let title: String
    @Binding private var selection: Selection
    private let options: [Selection]
    private let label: (Selection) -> String

    /// Creates a neumorphic menu for choosing one value.
    ///
    /// - Parameters:
    ///   - title: The accessibility label for the menu trigger.
    ///   - selection: A binding to the selected value.
    ///   - options: The values available for selection.
    ///   - label: A closure that provides display text for each value.
    public init(
        _ title: String, selection: Binding<Selection>, options: [Selection],
        label: @escaping (Selection) -> String = { String(describing: $0) }
    ) {
        self.title = title
        self._selection = selection
        self.options = options
        self.label = label
    }

    /// The rendered menu.
    public var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button {
                    selection = option
                } label: {
                    Text(label(option))
                }
            }
        } label: {
            HStack(spacing: 8) {
                Text(label(selection)).lineLimit(nil)
                Text("⌄")
            }
            .frame(minWidth: 120, minHeight: 44)
        }
        .buttonStyle(
            SoftDynamicButtonStyle(
                Capsule(), mainColor: theme.mainColor, textColor: theme.secondaryColor,
                darkShadowColor: theme.darkShadowColor, lightShadowColor: theme.lightShadowColor, pressedEffect: .hard,
                padding: 10)
        )
        .neumorphicButtonAccessibility(label: title, hint: "Double-tap to choose an option")
    }
}
