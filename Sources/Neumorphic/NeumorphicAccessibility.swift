import SwiftUI

extension View {
    @ViewBuilder
    func neumorphicSliderAccessibility(label: String, value: String, adjust: @escaping (AccessibilityAdjustmentDirection) -> Void) -> some View {
        #if os(iOS)
        if #available(iOS 14.0, *) {
            self.accessibilityElement().accessibilityLabel(Text(label)).accessibilityValue(Text(value)).accessibilityAdjustableAction(adjust)
        } else { self }
        #elseif os(macOS)
        if #available(macOS 11.0, *) {
            self.accessibilityElement().accessibilityLabel(Text(label)).accessibilityValue(Text(value)).accessibilityAdjustableAction(adjust)
        } else { self }
        #endif
    }

    @ViewBuilder
    func neumorphicProgressAccessibility(label: String, value: String) -> some View {
        #if os(iOS)
        if #available(iOS 14.0, *) { self.accessibilityElement().accessibilityLabel(Text(label)).accessibilityValue(Text(value)) } else { self }
        #elseif os(macOS)
        if #available(macOS 11.0, *) { self.accessibilityElement().accessibilityLabel(Text(label)).accessibilityValue(Text(value)) } else { self }
        #endif
    }

    @ViewBuilder
    func neumorphicSelectionAccessibility(label: String, selected: Bool) -> some View {
        #if os(iOS)
        if #available(iOS 14.0, *) { self.accessibilityLabel(Text(label)).accessibilityValue(Text(selected ? "Selected" : "Not selected")) } else { self }
        #elseif os(macOS)
        if #available(macOS 11.0, *) { self.accessibilityLabel(Text(label)).accessibilityValue(Text(selected ? "Selected" : "Not selected")) } else { self }
        #endif
    }

    @ViewBuilder
    func neumorphicButtonAccessibility(label: String, hint: String? = nil) -> some View {
        #if os(iOS)
        if #available(iOS 14.0, *) {
            if let hint { self.accessibilityLabel(Text(label)).accessibilityHint(Text(hint)) } else { self.accessibilityLabel(Text(label)) }
        } else { self }
        #elseif os(macOS)
        if #available(macOS 11.0, *) {
            if let hint { self.accessibilityLabel(Text(label)).accessibilityHint(Text(hint)) } else { self.accessibilityLabel(Text(label)) }
        } else { self }
        #endif
    }
}
