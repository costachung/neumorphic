import Neumorphic
import SwiftUI

struct ExampleSettingsView: View {
    @State private var highContrast = false
    #if os(macOS)
        @State private var isHovered = false
    #endif
    @State private var reduceMotion = false
    @State private var isOn = false

    private var theme: NeumorphicTheme { highContrast ? .highContrast : .standard }

    var body: some View {
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Settings & States")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.Neumorphic.secondary)
                        .exampleHeaderTrait()
                    SettingsSection("Theme") {
                        Toggle("High Contrast Theme", isOn: $highContrast)
                            .neumorphicThemedSwitchStyle(labelsHidden: false)
                        AdaptiveStack(spacing: 12, minimumHorizontalWidth: 420) {
                            Button("Themed Button", action: {})
                                .neumorphicThemedButtonStyle(Capsule())
                                .frame(maxWidth: .infinity)
                            Toggle("Themed Toggle", isOn: $isOn)
                                .neumorphicThemedToggleStyle(Capsule(), padding: 10)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    SettingsSection("Accessibility States") {
                        FocusRingPreview()
                        #if os(macOS)
                            HoverPreview(isHovered: $isHovered)
                        #endif
                        Toggle("Simulate Reduce Motion", isOn: $reduceMotion)
                            .neumorphicThemedSwitchStyle(labelsHidden: false)
                        MotionPreview()
                            .environment(\.exampleReduceMotionPreview, reduceMotion)
                    }
                    SettingsSection("Shadow Presets") {
                        AdaptiveStack(spacing: 18, minimumHorizontalWidth: 360) {
                            ShadowPresetDemo(title: "Standard", preset: .standard)
                            ShadowPresetDemo(title: "Subtle", preset: .subtle)
                            ShadowPresetDemo(title: "None", preset: .none)
                        }
                    }
                    SettingsSection("Style Entry Points") {
                        AdaptiveStack(minimumHorizontalWidth: 360) {
                            Button(action: {}) { ExampleSymbol(systemName: "star.fill") }
                                .buttonStyle(
                                    FixedSizeSoftDynamicButtonStyle(
                                        Circle(),
                                        mainColor: Color.Neumorphic.main,
                                        textColor: Color.Neumorphic.secondary,
                                        darkShadowColor: Color.Neumorphic.darkShadow,
                                        lightShadowColor: Color.Neumorphic.lightShadow,
                                        pressedEffect: .hard,
                                        padding: 0,
                                        size: CGSize(width: 56, height: 56)
                                    )
                                )
                                .accessibility(label: Text("Favorite"))
                                .frame(maxWidth: .infinity)
                            Toggle("Neumorphic Switch", isOn: $isOn)
                                .toggleStyle(NeumorphicSwitchToggleStyle())
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .neumorphicTheme(theme)
    }
}

private struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content

    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.Neumorphic.secondary)
                .exampleHeaderTrait()
            content
        }
    }
}

private struct FocusRingPreview: View {
    @ViewBuilder
    var body: some View {
        #if os(macOS)
            if #available(macOS 12.0, *) {
                FocusStateRingControl()
            } else {
                LegacyFocusRingControl()
            }
        #else
            if #available(iOS 15.0, *) {
                FocusStateRingControl()
            } else {
                ManualFocusRingControl()
            }
        #endif
    }
}

@available(iOS 15.0, macOS 12.0, *)
private struct FocusStateRingControl: View {
    @FocusState private var isFocused: Bool

    private var ringBinding: Binding<Bool> {
        Binding(get: { isFocused }, set: { isFocused = $0 })
    }

    private var control: some View {
        Button("Keyboard Focus", action: {})
            .neumorphicThemedButtonStyle(Capsule())
            .neumorphicFocusRing(Capsule(), isFocused: ringBinding)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            #if os(macOS)
                control
                    .focusable()
                    .focused($isFocused)
            #else
                control.focused($isFocused)
            #endif
            Text(isFocused ? "Keyboard focus is active" : "Use Tab to move keyboard focus here")
                .font(.caption)
                .foregroundColor(Color.Neumorphic.secondary)
        }
    }
}

#if os(macOS)
    @available(macOS, introduced: 10.15, obsoleted: 12.0)
    private struct LegacyFocusRingControl: View {
        @State private var isFocused = false

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Button("Keyboard Focus", action: {})
                    .neumorphicThemedButtonStyle(Capsule())
                    .neumorphicFocusRing(Capsule(), isFocused: $isFocused)
                    .focusable(true) { isFocused = $0 }
                Text(isFocused ? "Keyboard focus is active" : "Use Tab to move keyboard focus here")
                    .font(.caption)
                    .foregroundColor(Color.Neumorphic.secondary)
            }
        }
    }

    private struct HoverPreview: View {
        @Binding var isHovered: Bool
        @State private var clickCount = 0

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Button("Hover & Click") { clickCount += 1 }
                    .neumorphicThemedButtonStyle(Capsule())
                    .neumorphicHover(Capsule(), isHovered: $isHovered)
                Text("Clicks: \(clickCount)")
                    .font(.caption)
                    .foregroundColor(Color.Neumorphic.secondary)
            }
        }
    }
#endif

private struct ManualFocusRingControl: View {
    @State private var isFocused = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(isFocused ? "Clear Manual Focus" : "Manual Focus Preview") {
                isFocused.toggle()
            }
            .neumorphicThemedButtonStyle(Capsule())
            .neumorphicFocusRing(Capsule(), isFocused: $isFocused)
            Text("Manual preview for systems without FocusState")
                .font(.caption)
                .foregroundColor(Color.Neumorphic.secondary)
        }
    }
}

private struct MotionPreview: View {
    @Environment(\.accessibilityReduceMotion) private var systemReduceMotion
    @Environment(\.exampleReduceMotionPreview) private var previewReduceMotion
    @State private var isActive = false

    private var reduceMotion: Bool {
        (previewReduceMotion ?? false) || systemReduceMotion
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: togglePreview) {
                VStack(spacing: 8) {
                    ExampleSymbol(systemName: "sparkles")
                        .font(.title)
                        .rotationEffect(.degrees(isActive ? 180 : 0))
                        .scaleEffect(isActive ? 1.35 : 0.85)
                        .offset(x: isActive ? 28 : -28)
                    Text("Run Motion Preview")
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            }
            .neumorphicThemedButtonStyle(RoundedRectangle(cornerRadius: 16))
            Text(reduceMotion ? "Reduce Motion: state changes are immediate" : "Motion enabled: transition is animated")
                .font(.caption)
                .foregroundColor(Color.Neumorphic.secondary)
        }
    }

    private func togglePreview() {
        if reduceMotion {
            isActive.toggle()
        } else {
            withAnimation(.easeInOut(duration: 0.65)) { isActive.toggle() }
        }
    }
}

private struct ExampleReduceMotionPreviewKey: EnvironmentKey {
    static let defaultValue: Bool? = nil
}

private extension EnvironmentValues {
    var exampleReduceMotionPreview: Bool? {
        get { self[ExampleReduceMotionPreviewKey.self] }
        set { self[ExampleReduceMotionPreviewKey.self] = newValue }
    }
}

private struct ShadowPresetDemo: View {
    let title: String
    let preset: NeumorphicShadowPreset

    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(Color.Neumorphic.main)
                .frame(width: 58, height: 58)
                .softOuterShadow(preset)
            Text(title)
                .font(.caption)
                .foregroundColor(Color.Neumorphic.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ExampleSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExampleSettingsView()
                .previewDisplayName("Settings")
            ExampleSettingsView()
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewDisplayName("Settings · Largest Text")
        }
    }
}
