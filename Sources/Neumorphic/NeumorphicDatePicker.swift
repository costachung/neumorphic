import SwiftUI

/// A date picker presented on a soft inset surface.
public struct NeumorphicDatePicker: View {
    private let title: String
    @Binding private var selection: Date
    private let range: ClosedRange<Date>?
    private let displayedComponents: DatePickerComponents

    public init(_ title: String, selection: Binding<Date>, in range: ClosedRange<Date>? = nil, displayedComponents: DatePickerComponents = [.date, .hourAndMinute]) {
        self.title = title
        self._selection = selection
        self.range = range
        self.displayedComponents = displayedComponents
    }

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
        .foregroundColor(Color.Neumorphic.secondary)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.Neumorphic.main).softOuterShadow(.subtle))
    }
}
