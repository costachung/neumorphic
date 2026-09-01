import SwiftUI

/// An expandable group with a soft raised header. 
public struct NeumorphicDisclosureGroup<Content: View>: View {
    @Environment(\.neumorphicTheme) private var theme
    private let title: String
    @Binding private var isExpanded: Bool
    private let content: Content

    /// Creates an expandable neumorphic group.
    ///
    /// - Parameters:
    ///   - title: The text displayed in the group header.
    ///   - isExpanded: A binding that controls whether the content is visible.
    ///   - content: The content revealed when the group is expanded.
    public init(_ title: String, isExpanded: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.title = title
        self._isExpanded = isExpanded
        self.content = content()
    }

    /// The rendered disclosure group.
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button {
                isExpanded.toggle()
            } label: {
                HStack {
                    Text(title).font(.headline)
                    Spacer()
                    Text(isExpanded ? "⌃" : "⌄").font(.headline)
                }
                .foregroundColor(theme.secondaryColor)
                .frame(minHeight: 44)
            }
            .buttonStyle(PlainButtonStyle())
            .neumorphicButtonAccessibility(
                label: title, hint: isExpanded ? "Double-tap to collapse" : "Double-tap to expand")
            if isExpanded {
                content
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
            }
        }
        .padding(.horizontal, 14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(theme.mainColor)
                .softOuterShadow(.subtle)
        )
    }
}
