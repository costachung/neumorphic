import SwiftUI

/// An expandable group with a soft raised header.
public struct NeumorphicDisclosureGroup<Content: View>: View {
    private let title: String
    @Binding private var isExpanded: Bool
    private let content: Content

    public init(_ title: String, isExpanded: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.title = title
        self._isExpanded = isExpanded
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button { isExpanded.toggle() } label: {
                HStack {
                    Text(title).font(.headline)
                    Spacer()
                    Text(isExpanded ? "⌃" : "⌄").font(.headline)
                }
                .foregroundColor(Color.Neumorphic.secondary)
                .frame(minHeight: 44)
            }
            .buttonStyle(PlainButtonStyle())
            .neumorphicButtonAccessibility(label: title, hint: isExpanded ? "Double-tap to collapse" : "Double-tap to expand")
            if isExpanded {
                content
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
            }
        }
        .padding(.horizontal, 14)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.Neumorphic.main).softOuterShadow(.subtle))
    }
}
