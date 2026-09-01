import Combine
import Foundation
import SwiftUI 

/// A neumorphic slider with an inset track and raised thumb.
public struct NeumorphicSlider: View {
    @Environment(\.neumorphicTheme) private var theme
    @Binding private var value: Double
    @State private var editingSession = NeumorphicSliderEditingSession()
    @GestureState private var isDragging = false
    private let bounds: ClosedRange<Double>
    private let step: Double
    private let tint: Color
    private let accessibilityLabel: Text
    private let onEditingChanged: (Bool) -> Void

    /// Creates a slider bound to a value within the supplied range.
    ///
    /// - Parameters:
    ///   - value: A binding to the slider value.
    ///   - bounds: The range of representable values.
    ///   - step: The increment between selectable values. Zero allows continuous
    ///     adjustment, and negative values are normalized to zero.
    ///   - tint: The color of the filled portion of the track.
    ///   - onEditingChanged: A closure called when editing begins and ends.
    public init(
        value: Binding<Double>, in bounds: ClosedRange<Double> = 0...1, step: Double = 0, tint: Color = .accentColor,
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) {
        self.init(
            value: value,
            in: bounds,
            step: step,
            tint: tint,
            accessibilityLabel: Text(LocalizedStringKey("Slider")),
            onEditingChanged: onEditingChanged
        )
    }

    /// Creates a slider with an explicit accessibility label.
    ///
    /// - Parameters:
    ///   - value: A binding to the slider value.
    ///   - bounds: The range of representable values.
    ///   - step: The increment between selectable values. Zero allows continuous
    ///     adjustment, and negative values are normalized to zero.
    ///   - tint: The color of the filled portion of the track.
    ///   - accessibilityLabel: The label VoiceOver announces for the control.
    ///   - onEditingChanged: A closure called when editing begins and ends.
    public init(
        value: Binding<Double>, in bounds: ClosedRange<Double> = 0...1, step: Double = 0, tint: Color = .accentColor,
        accessibilityLabel: String = "Slider", onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) {
        self._value = value
        self.bounds = bounds
        self.step = max(step, 0)
        self.tint = tint
        self.accessibilityLabel = Text(verbatim: accessibilityLabel)
        self.onEditingChanged = onEditingChanged
    }

    private init(
        value: Binding<Double>, in bounds: ClosedRange<Double>, step: Double, tint: Color,
        accessibilityLabel: Text, onEditingChanged: @escaping (Bool) -> Void
    ) {
        self._value = value
        self.bounds = bounds
        self.step = max(step, 0)
        self.tint = tint
        self.accessibilityLabel = accessibilityLabel
        self.onEditingChanged = onEditingChanged
    }

    /// The slider's visual and interactive content.
    public var body: some View {
        let slider = GeometryReader { proxy in
            let width = max(proxy.size.width, 1)
            let progress = normalizedValue
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(theme.mainColor)
                    .softInnerShadow(
                        Capsule(),
                        darkShadow: theme.darkShadowColor,
                        lightShadow: theme.lightShadowColor,
                        spread: 0.5,
                        radius: 3
                    )
                Capsule().fill(tint.opacity(0.8)).frame(width: max(0, width * progress), height: 6)
                Circle().fill(theme.mainColor).frame(width: 28, height: 28)
                    .softOuterShadow(
                        darkShadow: theme.darkShadowColor,
                        lightShadow: theme.lightShadowColor,
                        offset: 3,
                        radius: 2
                    )
                    .overlay(Circle().fill(tint).frame(width: 10, height: 10))
                    .offset(x: max(width - 28, 0) * progress)
            }
            .frame(height: 28)
            .frame(maxHeight: .infinity)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .updating($isDragging) { _, state, _ in
                        state = true
                    }
                    .onChanged { gesture in
                        updateValue(at: gesture.location.x, width: width)
                    }
                    .onEnded { _ in
                        endEditing()
                    }
            )
        }
        .frame(height: 44)
        .onReceive(Just(isDragging).removeDuplicates()) { isDragging in
            if isDragging {
                beginEditing()
            } else {
                endEditing()
            }
        }
        .onDisappear(perform: endEditing)
        .neumorphicSliderAccessibility(label: accessibilityLabel, value: accessibilityValue) {
            direction in
            adjustValue(for: direction)
        }

        #if os(macOS)
            slider
                .modifier(
                    NeumorphicSliderKeyboardInteraction(
                        onMove: adjustValue(for:)
                    )
                )
        #else
            slider
        #endif
    }

    private var normalizedValue: CGFloat {
        CGFloat(NeumorphicSliderMath.normalizedFraction(value: value, in: bounds))
    }

    private var accessibilityValue: String {
        NeumorphicSliderMath.percentString(
            NeumorphicSliderMath.normalizedFraction(value: value, in: bounds)
        )
    }

    private func updateValue(at x: CGFloat, width: CGFloat) {
        value = NeumorphicSliderMath.value(
            at: NeumorphicSliderMath.fraction(at: Double(x), width: Double(width)),
            in: bounds,
            step: step
        )
    }

    private func beginEditing() {
        if editingSession.begin() {
            onEditingChanged(true)
        }
    }

    private func endEditing() {
        if editingSession.end() {
            onEditingChanged(false)
        }
    }

    private func adjustValue(for direction: AccessibilityAdjustmentDirection) {
        switch direction {
        case .increment:
            value = NeumorphicSliderMath.adjustedValue(value, in: bounds, step: step, incrementing: true)
        case .decrement:
            value = NeumorphicSliderMath.adjustedValue(value, in: bounds, step: step, incrementing: false)
        @unknown default:
            break
        }
    }

    #if os(macOS)
        private func adjustValue(for direction: MoveCommandDirection) {
            switch direction {
            case .right, .up:
                value = NeumorphicSliderMath.adjustedValue(value, in: bounds, step: step, incrementing: true)
            case .left, .down:
                value = NeumorphicSliderMath.adjustedValue(value, in: bounds, step: step, incrementing: false)
            @unknown default:
                break
            }
        }
    #endif
}

#if os(macOS)
    private struct NeumorphicSliderKeyboardInteraction: ViewModifier {
        @State private var isFocused = false
        let onMove: (MoveCommandDirection) -> Void

        @ViewBuilder
        func body(content: Content) -> some View {
            if #available(macOS 12.0, *) {
                NeumorphicSliderModernKeyboardTarget(
                    content: content,
                    onMove: onMove
                )
            } else {
                content
                    .focusable(true) { isFocused = $0 }
                    .onMoveCommand(perform: onMove)
                    .neumorphicFocusRing(Capsule(), isFocused: $isFocused)
            }
        }
    }

    @available(macOS 12.0, *)
    private struct NeumorphicSliderModernKeyboardTarget<Content: View>: View {
        let content: Content
        let onMove: (MoveCommandDirection) -> Void
        @FocusState private var focus: Bool

        private var ringBinding: Binding<Bool> {
            Binding(get: { focus }, set: { focus = $0 })
        }

        var body: some View {
            content
                .focusable()
                .focused($focus)
                .onMoveCommand(perform: onMove)
                .neumorphicFocusRing(Capsule(), isFocused: ringBinding)
        }
    }
#endif

struct NeumorphicSliderEditingSession {
    private(set) var isEditing = false

    mutating func begin() -> Bool {
        guard !isEditing else { return false }
        isEditing = true
        return true
    }

    mutating func end() -> Bool {
        guard isEditing else { return false }
        isEditing = false
        return true
    }
}

enum NeumorphicSliderMath {
    static func normalizedFraction(value: Double, in bounds: ClosedRange<Double>) -> Double {
        guard value.isFinite, bounds.lowerBound.isFinite, bounds.upperBound.isFinite,
            bounds.upperBound > bounds.lowerBound
        else { return 0 }
        return min(max((value - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound), 0), 1)
    }

    static func fraction(at x: Double, width: Double, thumbWidth: Double = 28) -> Double {
        guard x.isFinite, width.isFinite, width > 0, thumbWidth.isFinite, thumbWidth >= 0 else { return 0 }
        let travel = max(width - thumbWidth, 1)
        return min(max((x - thumbWidth / 2) / travel, 0), 1)
    }

    static func percentString(_ fraction: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: min(max(fraction, 0), 1))) ?? "0%"
    }

    static func value(at fraction: Double, in bounds: ClosedRange<Double>, step: Double) -> Double {
        guard fraction.isFinite, bounds.lowerBound.isFinite, bounds.upperBound.isFinite,
            bounds.upperBound >= bounds.lowerBound
        else { return bounds.lowerBound.isFinite ? bounds.lowerBound : 0 }
        let clampedFraction = min(max(fraction, 0), 1)
        let rawValue = bounds.lowerBound + (bounds.upperBound - bounds.lowerBound) * clampedFraction
        return snappedValue(rawValue, in: bounds, step: step)
    }

    static func adjustedValue(
        _ value: Double,
        in bounds: ClosedRange<Double>,
        step: Double,
        incrementing: Bool
    ) -> Double {
        guard value.isFinite, bounds.lowerBound.isFinite, bounds.upperBound.isFinite,
            bounds.upperBound >= bounds.lowerBound
        else { return bounds.lowerBound.isFinite ? bounds.lowerBound : 0 }
        let clampedValue = min(max(value, bounds.lowerBound), bounds.upperBound)
        guard step.isFinite, step > 0 else {
            let delta = (bounds.upperBound - bounds.lowerBound) / 20
            return min(
                max(clampedValue + (incrementing ? delta : -delta), bounds.lowerBound),
                bounds.upperBound
            )
        }

        let position = (clampedValue - bounds.lowerBound) / step
        let nearestPosition = position.rounded()
        let tolerance = Double.ulpOfOne * 16 * max(1, abs(position))
        let isAligned = abs(position - nearestPosition) <= tolerance
        let targetPosition: Double
        if incrementing {
            targetPosition = isAligned ? nearestPosition + 1 : position.rounded(.up)
        } else {
            targetPosition = isAligned ? nearestPosition - 1 : position.rounded(.down)
        }

        return min(
            max(bounds.lowerBound + targetPosition * step, bounds.lowerBound),
            bounds.upperBound
        )
    }

    private static func snappedValue(
        _ value: Double,
        in bounds: ClosedRange<Double>,
        step: Double
    ) -> Double {
        guard value.isFinite, bounds.lowerBound.isFinite, bounds.upperBound.isFinite,
            bounds.upperBound >= bounds.lowerBound
        else { return bounds.lowerBound.isFinite ? bounds.lowerBound : 0 }
        let clampedValue = min(max(value, bounds.lowerBound), bounds.upperBound)
        guard step.isFinite, step > 0 else { return clampedValue }
        let stepCount = ((clampedValue - bounds.lowerBound) / step).rounded()
        return min(
            max(bounds.lowerBound + stepCount * step, bounds.lowerBound),
            bounds.upperBound
        )
    }
}
