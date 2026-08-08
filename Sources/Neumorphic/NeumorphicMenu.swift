import SwiftUI

/// A menu button with a raised neumorphic trigger surface.
@available(iOS 14.0, macOS 11.0, *)
public struct NeumorphicMenu<Selection: Hashable>: View {
    private let title: String
    @Binding private var selection: Selection
    private let options: [Selection]
    private let label: (Selection) -> String

    public init(_ title: String, selection: Binding<Selection>, options: [Selection], label: @escaping (Selection) -> String = { String(describing: $0) }) {
        self.title = title
        self._selection = selection
        self.options = options
        self.label = label
    }

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
        .buttonStyle(SoftDynamicButtonStyle(Capsule(), mainColor: .Neumorphic.main, textColor: .Neumorphic.secondary, darkShadowColor: .Neumorphic.darkShadow, lightShadowColor: .Neumorphic.lightShadow, pressedEffect: .hard, padding: 10))
        .neumorphicButtonAccessibility(label: title, hint: "Double-tap to choose an option")
    }
}
