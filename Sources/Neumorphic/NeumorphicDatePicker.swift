import SwiftUI

/// A date picker presented on a soft inset surface.
public struct NeumorphicDatePicker: View {
    @Environment(\.neumorphicTheme) private var theme
    private let title: String
    @Binding private var selection: Date
    private let range: ClosedRange<Date>?
    private let displayedComponents: DatePickerComponents

    /// Creates a date picker on a neumorphic surface.
    ///
    /// - Parameters:
    ///   - title: The text that describes the date selection.
    ///   - selection: A binding to the selected date.
    ///   - range: The optional range of selectable dates.
    ///   - displayedComponents: The date components available for editing.
    public init(
        _ title: String, selection: Binding<Date>, in range: ClosedRange<Date>? = nil,
        displayedComponents: DatePickerComponents = [.date, .hourAndMinute]
    ) {
        self.title = title
        self._selection = selection
        self.range = range
        self.displayedComponents = displayedComponents
    }

    /// The rendered date picker.
    public var body: some View {
        Group {
            if let range {
                DatePicker(title, selection: $selection, in: range, displayedComponents: displayedComponents)
            } else {
                DatePicker(title, selection: $selection, displayedComponents: displayedComponents)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .foregroundColor(theme.secondaryColor)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(theme.mainColor)
                .softOuterShadow(.subtle)
        )
    }
}
