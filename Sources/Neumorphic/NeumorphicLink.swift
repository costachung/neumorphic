import SwiftUI
 
/// A link rendered as a neumorphic raised action.
@available(iOS 14.0, macOS 11.0, *)
public struct NeumorphicLink<Label: View>: View {
    @Environment(\.neumorphicTheme) private var theme
    private let destination: URL
    private let label: Label

    /// Creates a neumorphic link with custom label content.
    ///
    /// - Parameters:
    ///   - destination: The URL to open when the link is activated.
    ///   - label: A view builder that creates the link label.
    public init(destination: URL, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }

    /// The rendered link.
    public var body: some View {
        Link(destination: destination) {
            label.foregroundColor(theme.secondaryColor).frame(minHeight: 44)
        }
        .padding(.horizontal, 14)
        .background(
            Capsule()
                .fill(theme.mainColor)
                .softOuterShadow(.subtle)
        )
    }
}

@available(iOS 14.0, macOS 11.0, *)
public extension NeumorphicLink where Label == Text {
    /// Creates a neumorphic link with a text label.
    ///
    /// - Parameters:
    ///   - title: The text displayed by the link.
    ///   - destination: The URL to open when the link is activated.
    init(_ title: String, destination: URL) {
        self.init(destination: destination) { Text(title) }
    }
}
