import SwiftUI

/// A link rendered as a neumorphic raised action.
@available(iOS 14.0, macOS 11.0, *)
public struct NeumorphicLink<Label: View>: View {
    private let destination: URL
    private let label: Label

    public init(destination: URL, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }

    public var body: some View {
        Link(destination: destination) {
            label.foregroundColor(Color.Neumorphic.secondary).frame(minHeight: 44)
        }
        .padding(.horizontal, 14)
        .background(Capsule().fill(Color.Neumorphic.main).softOuterShadow(.subtle))
    }
}

@available(iOS 14.0, macOS 11.0, *)
public extension NeumorphicLink where Label == Text {
    init(_ title: String, destination: URL) {
        self.init(destination: destination) { Text(title) }
    }
}
