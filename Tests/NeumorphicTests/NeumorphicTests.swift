import SwiftUI
import XCTest

@testable import Neumorphic

final class NeumorphicTests: XCTestCase {
    func testColorSchemeTypeRoundTrips() {
        let original = NeumorphicKit.colorSchemeType
        defer { NeumorphicKit.colorSchemeType = original }

        NeumorphicKit.colorSchemeType = .light
        XCTAssertTrue(isColorScheme(.light, equalTo: NeumorphicKit.colorSchemeType))

        NeumorphicKit.colorSchemeType = .dark
        XCTAssertTrue(isColorScheme(.dark, equalTo: NeumorphicKit.colorSchemeType))

        NeumorphicKit.colorSchemeType = .auto
        XCTAssertTrue(isColorScheme(.auto, equalTo: NeumorphicKit.colorSchemeType))
    }

    func testNeumorphicColorsCanBeResolvedForEveryColorScheme() {
        let original = NeumorphicKit.colorSchemeType
        defer { NeumorphicKit.colorSchemeType = original }

        var resolvedColorCount = 0
        for scheme in [NeumorphicKit.ColorSchemeType.auto, .light, .dark] {
            NeumorphicKit.colorSchemeType = scheme
            _ = Color.Neumorphic.main
            _ = Color.Neumorphic.secondary
            _ = Color.Neumorphic.lightShadow
            _ = Color.Neumorphic.darkShadow
            resolvedColorCount += 4
        }

        XCTAssertEqual(resolvedColorCount, 12)
    }

    @MainActor
    func testPublicStyleEntryPointsCompile() {
        let toggle = Toggle("Enabled", isOn: .constant(false))
            .toggleStyle(.neumorphicSwitch)
            .disabled(true)
        let button = Button("Save", action: {})
            .softButtonStyle(Capsule())
        let softToggle = Toggle("Favorite", isOn: .constant(false))
            .softToggleStyle(Capsule())
        let softSwitch = Toggle("Notifications", isOn: .constant(false))
            .softSwitchToggleStyle()

        _ = toggle
        _ = button
        _ = softToggle
        _ = softSwitch
        XCTAssertFalse(String(describing: type(of: toggle)).isEmpty)
        XCTAssertFalse(String(describing: type(of: button)).isEmpty)
        XCTAssertFalse(String(describing: type(of: softToggle)).isEmpty)
        XCTAssertFalse(String(describing: type(of: softSwitch)).isEmpty)
    }

    func testStyleParametersNormalizeNegativeGeometry() {
        let inner = Text("Inner")
            .softInnerShadow(RoundedRectangle(cornerRadius: 4), spread: -1, radius: -10)
        let outer = Text("Outer")
            .softOuterShadow(offset: -4, radius: -2)
        let fixed = Button("Fixed", action: {})
            .fixedSizeSoftButtonStyle(size: CGSize(width: -10, height: -10))
        let toggle = Toggle("Switch", isOn: .constant(false))
            .toggleStyle(NeumorphicSwitchToggleStyle(height: -5))

        XCTAssertFalse(String(describing: type(of: inner)).isEmpty)
        XCTAssertFalse(String(describing: type(of: outer)).isEmpty)
        XCTAssertFalse(String(describing: type(of: fixed)).isEmpty)
        XCTAssertFalse(String(describing: type(of: toggle)).isEmpty)
    }

    func testFocusRingEntryPointCompiles() {
        let focused = Text("Focused")
            .neumorphicFocusRing(Capsule(), isFocused: .constant(true))

        XCTAssertFalse(String(describing: type(of: focused)).isEmpty)
    }

    func testThemeEntryPointsCompile() {
        // The theme must sit above the themed modifiers: environment values only
        // travel downward, so `neumorphicTheme` goes on an ancestor, never after
        // the modifier that reads it.
        let button = VStack {
            Button("Save", action: {})
                .neumorphicThemedButtonStyle(Capsule())
            Button("Continue", action: {})
                .neumorphicThemedButtonStyle(Capsule(), role: .accent)
        }
        .neumorphicTheme(.highContrast)
        let toggle = VStack {
            Toggle("Enabled", isOn: .constant(false))
                .neumorphicThemedToggleStyle(Capsule())
        }
        .neumorphicTheme(.standard)
        let switchView = Toggle("Switch", isOn: .constant(false))
            .neumorphicThemedSwitchStyle(labelsHidden: true)

        XCTAssertFalse(String(describing: type(of: button)).isEmpty)
        XCTAssertFalse(String(describing: type(of: toggle)).isEmpty)
        XCTAssertFalse(String(describing: type(of: switchView)).isEmpty)
    }

    func testThemeEnvironmentDefaultsToStandardAndAcceptsOverrides() {
        var values = EnvironmentValues()
        XCTAssertEqual(values.neumorphicTheme.mainColor, NeumorphicTheme.standard.mainColor)

        values.neumorphicTheme = .highContrast
        XCTAssertEqual(values.neumorphicTheme.mainColor, NeumorphicTheme.highContrast.mainColor)
        XCTAssertNotEqual(values.neumorphicTheme.mainColor, NeumorphicTheme.standard.mainColor)
    }

    func testButtonRolesResolveStandardAndHighContrastThemeColors() {
        for theme in [NeumorphicTheme.standard, .highContrast] {
            let surface = theme.resolvedButtonColors(for: .surface)
            XCTAssertEqual(surface.surface, theme.mainColor)
            XCTAssertEqual(surface.foreground, theme.secondaryColor)

            let accent = theme.resolvedButtonColors(for: .accent)
            XCTAssertEqual(accent.surface, theme.accentColor)
            XCTAssertEqual(accent.foreground, theme.onAccentColor)
        }
    }

    func testFourColorThemeInitializerPreservesExistingButtonBehavior() {
        let theme = NeumorphicTheme(
            mainColor: .white,
            secondaryColor: .black,
            darkShadowColor: .gray,
            lightShadowColor: .yellow
        )

        XCTAssertEqual(theme.accentColor, theme.secondaryColor)
        XCTAssertEqual(theme.onAccentColor, theme.mainColor)
    }

    func testSixColorThemeInitializerKeepsCustomAccentPair() {
        let theme = NeumorphicTheme(
            mainColor: .white,
            secondaryColor: .black,
            accentColor: .blue,
            onAccentColor: .yellow,
            darkShadowColor: .gray,
            lightShadowColor: .orange
        )
        let accent = theme.resolvedButtonColors(for: .accent)

        XCTAssertEqual(accent.surface, .blue)
        XCTAssertEqual(accent.foreground, .yellow)
    }

    func testShadowPresetFollowsThemeUnlessColorsAreExplicit() {
        let highContrast = NeumorphicTheme.highContrast

        // `.standard` and `.subtle` derive their colors from whichever theme is applied.
        let (standardDark, standardLight) = NeumorphicShadowPreset.standard
            .resolvedShadowColors(for: highContrast)
        XCTAssertEqual(standardDark, highContrast.darkShadowColor.opacity(1))
        XCTAssertEqual(standardLight, highContrast.lightShadowColor.opacity(1))

        let (subtleDark, subtleLight) = NeumorphicShadowPreset.subtle
            .resolvedShadowColors(for: highContrast)
        XCTAssertEqual(subtleDark, highContrast.darkShadowColor.opacity(0.65))
        XCTAssertEqual(subtleLight, highContrast.lightShadowColor.opacity(0.65))

        // Swapping the theme changes the result, proving the preset tracks the theme
        // rather than the colors it was constructed with.
        let (standardColors, _) = NeumorphicShadowPreset.standard
            .resolvedShadowColors(for: .standard)
        XCTAssertNotEqual(standardDark, standardColors)

        // A preset built with explicit colors keeps them under any theme, which is the
        // behavior promised by `NeumorphicShadowPreset.init`.
        let custom = NeumorphicShadowPreset(darkShadowColor: .red, lightShadowColor: .blue)
        let (customUnderHighContrast, _) = custom.resolvedShadowColors(for: highContrast)
        let (customUnderStandard, _) = custom.resolvedShadowColors(for: .standard)
        XCTAssertEqual(customUnderHighContrast, .red)
        XCTAssertEqual(customUnderHighContrast, customUnderStandard)

        // `.none` is explicit too, so it stays transparent regardless of theme.
        let (noneDark, noneLight) = NeumorphicShadowPreset.none.resolvedShadowColors(for: highContrast)
        XCTAssertEqual(noneDark, .clear)
        XCTAssertEqual(noneLight, .clear)
    }

    func testHoverEntryPointCompiles() {
        let hover = Text("Hover")
            .neumorphicHover(Capsule(), isHovered: .constant(false))

        XCTAssertFalse(String(describing: type(of: hover)).isEmpty)
    }

    func testShadowPresetsNormalizeParameters() {
        let preset = NeumorphicShadowPreset(
            darkShadowColor: .black, lightShadowColor: .white, offset: -1, radius: -2, spread: 2)
        XCTAssertEqual(preset.offset, 0)
        XCTAssertEqual(preset.radius, 0)
        XCTAssertEqual(preset.spread, 1)
        let view = Text("Preset")
            .softOuterShadow(.subtle)
            .softInnerShadow(Capsule(), preset: .subtle)
        XCTAssertFalse(String(describing: type(of: view)).isEmpty)
    }

    func testCommonControlEntryPointsCompile() {
        let slider = NeumorphicSlider(value: .constant(0.5), in: 0...1, step: 0.1, accessibilityLabel: "Volume")
        let field = NeumorphicTextField("Name", text: .constant(""))
        let progress = NeumorphicProgressView(value: 0.5, total: 1, accessibilityLabel: "Upload progress")
        let picker = NeumorphicPicker(selection: .constant("One"), options: ["One", "Two"])

        XCTAssertFalse(String(describing: type(of: slider)).isEmpty)
        XCTAssertFalse(String(describing: type(of: field)).isEmpty)
        XCTAssertFalse(String(describing: type(of: progress)).isEmpty)
        XCTAssertFalse(String(describing: type(of: picker)).isEmpty)
    }

    func testRemainingControlEntryPointsCompile() {
        let stepper = NeumorphicStepper(value: .constant(2), in: 0...5)
        let checkbox = NeumorphicCheckbox("Remember", isOn: .constant(true))
        let radio = NeumorphicRadio("Light", value: "light", selection: .constant("light"))
        let card = Text("Card").neumorphicCard()

        XCTAssertFalse(String(describing: type(of: stepper)).isEmpty)
        XCTAssertFalse(String(describing: type(of: checkbox)).isEmpty)
        XCTAssertFalse(String(describing: type(of: radio)).isEmpty)
        XCTAssertFalse(String(describing: type(of: card)).isEmpty)
    }

    func testNextCommonControlEntryPointsCompile() {
        let datePicker = NeumorphicDatePicker("Start", selection: .constant(Date()))
        let menu = NeumorphicMenu("Mode", selection: .constant("Light"), options: ["Light", "Dark"])
        let disclosure = NeumorphicDisclosureGroup("Details", isExpanded: .constant(true)) { Text("Content") }
        let link = NeumorphicLink("Website", destination: URL(string: "https://example.com")!)
        let circular = NeumorphicCircularProgressView(value: 0.5)

        XCTAssertFalse(String(describing: type(of: datePicker)).isEmpty)
        XCTAssertFalse(String(describing: type(of: menu)).isEmpty)
        XCTAssertFalse(String(describing: type(of: disclosure)).isEmpty)
        XCTAssertFalse(String(describing: type(of: link)).isEmpty)
        XCTAssertFalse(String(describing: type(of: circular)).isEmpty)
    }

    func testSliderStepIsAnchoredToLowerBound() {
        let bounds = 5.0...10.0

        XCTAssertEqual(NeumorphicSliderMath.value(at: 0, in: bounds, step: 2), 5)
        XCTAssertEqual(NeumorphicSliderMath.value(at: 0.4, in: bounds, step: 2), 7)
        XCTAssertEqual(NeumorphicSliderMath.value(at: 0.6, in: bounds, step: 2), 9)
        XCTAssertEqual(NeumorphicSliderMath.value(at: 1, in: bounds, step: 2), 10)
    }

    func testSliderAccessibilityAdjustmentKeepsStepSequence() {
        let bounds = 5.0...10.0

        XCTAssertEqual(
            NeumorphicSliderMath.adjustedValue(5, in: bounds, step: 2, incrementing: true),
            7
        )
        XCTAssertEqual(
            NeumorphicSliderMath.adjustedValue(6, in: bounds, step: 2, incrementing: true),
            7
        )
        XCTAssertEqual(
            NeumorphicSliderMath.adjustedValue(10, in: bounds, step: 2, incrementing: false),
            9
        )
        XCTAssertEqual(
            NeumorphicSliderMath.adjustedValue(9, in: bounds, step: 2, incrementing: true),
            10
        )
    }

    func testSliderEditingSessionOnlyReportsTransitions() {
        var session = NeumorphicSliderEditingSession()

        XCTAssertTrue(session.begin())
        XCTAssertFalse(session.begin())
        XCTAssertTrue(session.end())
        XCTAssertFalse(session.end())
    }

    func testSliderDragMappingCompensatesThumbWidth() {
        XCTAssertEqual(NeumorphicSliderMath.fraction(at: 14, width: 100), 0)
        XCTAssertEqual(NeumorphicSliderMath.fraction(at: 50, width: 100), 0.5, accuracy: 0.001)
        XCTAssertEqual(NeumorphicSliderMath.fraction(at: 86, width: 100), 1)
    }

    func testSliderMathRejectsNonFiniteValues() {
        let bounds = 5.0...10.0

        XCTAssertEqual(NeumorphicSliderMath.value(at: .nan, in: bounds, step: 1), 5)
        XCTAssertEqual(
            NeumorphicSliderMath.adjustedValue(.nan, in: bounds, step: 1, incrementing: true),
            5
        )
        XCTAssertTrue(NeumorphicSliderMath.percentString(0.65).contains("65"))
    }

    func testProgressFractionClampsVisualAndAccessibilityValue() {
        XCTAssertEqual(NeumorphicProgressMath.normalizedFraction(value: -1, total: 10), 0)
        XCTAssertEqual(NeumorphicProgressMath.normalizedFraction(value: 5, total: 10), 0.5)
        XCTAssertEqual(NeumorphicProgressMath.normalizedFraction(value: 20, total: 10), 1)
        XCTAssertEqual(NeumorphicProgressMath.normalizedFraction(value: 5, total: 0), 0)
        XCTAssertEqual(NeumorphicProgressMath.normalizedFraction(value: .infinity, total: 10), 0)
        XCTAssertNil(NeumorphicProgressMath.normalizedFraction(value: nil, total: 10))
    }

    private func isColorScheme(
        _ lhs: NeumorphicKit.ColorSchemeType,
        equalTo rhs: NeumorphicKit.ColorSchemeType
    ) -> Bool {
        switch (lhs, rhs) {
        case (.auto, .auto), (.light, .light), (.dark, .dark):
            true
        default:
            false
        }
    }
}
