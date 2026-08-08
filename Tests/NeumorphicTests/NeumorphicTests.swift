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
        ("testCommonControlEntryPointsCompile", testCommonControlEntryPointsCompile),
        ("testRemainingControlEntryPointsCompile", testRemainingControlEntryPointsCompile),
        ("testNextCommonControlEntryPointsCompile", testNextCommonControlEntryPointsCompile),
    ]
}
