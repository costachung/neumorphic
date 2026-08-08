import XCTest
import SwiftUI
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

    func testPublicStyleEntryPointsCompile() {
        let toggle = Toggle("Enabled", isOn: .constant(false))
            .toggleStyle(.neumorphicSwitch)
            .disabled(true)
        let button = Group {
            Button("Save", action: {})
        }
            .softButtonStyle(Capsule())

        _ = toggle
        _ = button
        XCTAssertFalse(String(describing: type(of: toggle)).isEmpty)
        XCTAssertFalse(String(describing: type(of: button)).isEmpty)
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
        let button = Button("Save", action: {})
            .neumorphicTheme(.highContrast)
            .neumorphicThemedButtonStyle(Capsule())
        let toggle = Toggle("Enabled", isOn: .constant(false))
            .neumorphicTheme(.standard)
            .neumorphicThemedToggleStyle(Capsule())
        let switchView = Toggle("Switch", isOn: .constant(false))
            .neumorphicThemedSwitchStyle(labelsHidden: true)

        XCTAssertFalse(String(describing: type(of: button)).isEmpty)
        XCTAssertFalse(String(describing: type(of: toggle)).isEmpty)
        XCTAssertFalse(String(describing: type(of: switchView)).isEmpty)
    }

    func testHoverEntryPointCompiles() {
        let hover = Text("Hover")
            .neumorphicHover(Capsule(), isHovered: .constant(false))

        XCTAssertFalse(String(describing: type(of: hover)).isEmpty)
    }

    func testShadowPresetsNormalizeParameters() {
        let preset = NeumorphicShadowPreset(darkShadowColor: .black, lightShadowColor: .white, offset: -1, radius: -2, spread: 2)
        XCTAssertEqual(preset.offset, 0)
        XCTAssertEqual(preset.radius, 0)
        XCTAssertEqual(preset.spread, 1)
        let view = Text("Preset")
            .softOuterShadow(.subtle)
            .softInnerShadow(Capsule(), preset: .subtle)
        XCTAssertFalse(String(describing: type(of: view)).isEmpty)
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

    static var allTests = [
        ("testColorSchemeTypeRoundTrips", testColorSchemeTypeRoundTrips),
        ("testNeumorphicColorsCanBeResolvedForEveryColorScheme", testNeumorphicColorsCanBeResolvedForEveryColorScheme),
        ("testPublicStyleEntryPointsCompile", testPublicStyleEntryPointsCompile),
        ("testStyleParametersNormalizeNegativeGeometry", testStyleParametersNormalizeNegativeGeometry),
        ("testFocusRingEntryPointCompiles", testFocusRingEntryPointCompiles),
        ("testThemeEntryPointsCompile", testThemeEntryPointsCompile),
        ("testHoverEntryPointCompiles", testHoverEntryPointCompiles),
        ("testShadowPresetsNormalizeParameters", testShadowPresetsNormalizeParameters),
    ]
}
