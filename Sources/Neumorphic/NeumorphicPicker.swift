import SwiftUI

/// A compact segmented picker for a small set of hashable options.
public struct NeumorphicPicker<Selection: Hashable>: View {
    @Binding private var selection: Selection
    private let options: [Selection]
    private let label: (Selection) -> String

    public init(selection: Binding<Selection>, options: [Selection], label: @escaping (Selection) -> String = { String(describing: $0) }) {
        self._selection = selection
        self.options = options
        self.label = label
    }

    public var body: some View {
        HStack(spacing: 8) {
            ForEach(options, id: \.self) { option in
                Button { selection = option } label: {
                    Text(label(option)).font(.subheadline.weight(.medium)).lineLimit(1).frame(maxWidth: .infinity)
                }
                .buttonStyle(SoftDynamicButtonStyle(Capsule(), mainColor: .Neumorphic.main, textColor: .Neumorphic.secondary, darkShadowColor: .Neumorphic.darkShadow, lightShadowColor: .Neumorphic.lightShadow, pressedEffect: selection == option ? .flat : .none, padding: 10))
                .opacity(selection == option ? 1 : 0.75)
            }
        }
    }
}
