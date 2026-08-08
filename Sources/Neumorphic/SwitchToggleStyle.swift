//
//  SwitchToggleStyle.swift
//
//
//  Created by will on 2023/1/16.
//

import SwiftUI

/// A SwiftUI-compatible switch toggle style with Neumorphic visuals.
public struct NeumorphicSwitchToggleStyle: ToggleStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var tintColor: Color
    var offTintColor: Color

    var mainColor: Color
    var darkShadowColor: Color
    var lightShadowColor: Color

    var hideLabel: Bool
    var height: CGFloat
    var ratio: CGFloat { height / 45 }

    /// Creates a switch style with customizable colors and dimensions.
    public init(
        tint: Color = .green,
        offTint: Color = Color.Neumorphic.main,
        mainColor: Color = Color.Neumorphic.main,
        darkShadowColor: Color = Color.Neumorphic.darkShadow,
        lightShadowColor: Color = Color.Neumorphic.lightShadow,
        labelsHidden: Bool = false,
        height: CGFloat = 30
    ) {
        self.tintColor = tint
        self.offTintColor = offTint
        self.mainColor = mainColor
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.hideLabel = labelsHidden
        self.height = max(height, 1)
    }

    /// Builds the switch content for the current state.
    public func makeBody(configuration: Self.Configuration) -> some View {
        Button {
            withAnimation(reduceMotion ? nil : .easeInOut(duration: 0.2)) {
                configuration.isOn.toggle()
            }
        } label: {
            HStack {
                if !hideLabel {
                    configuration.label
                    Spacer()
                }
                ZStack {
                    Capsule()
                        .fill(mainColor)
                        .softOuterShadow()
                        .frame(width: 75 * ratio, height: 45 * ratio)

                    Capsule()
                        .fill(configuration.isOn ? tintColor : offTintColor)
                        .softInnerShadow(Capsule(), darkShadow: configuration.isOn ? tintColor : darkShadowColor, lightShadow: configuration.isOn ? tintColor : lightShadowColor, spread: 0.35, radius: 3 * ratio)
                        .frame(width: 70 * ratio, height: 40 * ratio)

                    Circle()
                        .fill(mainColor)
                        .softOuterShadow(darkShadow: darkShadowColor, lightShadow: lightShadowColor, offset: 2 * ratio, radius: 1 * ratio)
                        .frame(width: 30 * ratio, height: 30 * ratio)
                        .offset(x: configuration.isOn ? 15 * ratio : -15 * ratio)
                        .animation(reduceMotion ? nil : .easeInOut(duration: 0.2), value: configuration.isOn)
                }
                .opacity(isEnabled ? 1 : 0.3)
            }
        }
        .buttonStyle(.plain)
        .stateAccessibilityValue(configuration.isOn)
        .frame(minWidth: 44, minHeight: 44)
    }

}

private extension View {
    @ViewBuilder
    func stateAccessibilityValue(_ isOn: Bool) -> some View {
        if #available(macOS 11.0, iOS 14.0, *) {
            accessibilityValue(isOn ? "On" : "Off")
        } else {
            self
        }
    }
}

public extension View {
    /// Applies the Neumorphic switch toggle style.
    func switchToggleStyle(tint: Color = .green, offTint: Color = Color.Neumorphic.main, mainColor: Color = Color.Neumorphic.main, darkShadowColor: Color = Color.Neumorphic.darkShadow, lightShadowColor: Color = Color.Neumorphic.lightShadow, labelsHidden: Bool = false, height: CGFloat = 30) -> some View {
        toggleStyle(NeumorphicSwitchToggleStyle(tint: tint, offTint: offTint, mainColor: mainColor, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, labelsHidden: labelsHidden, height: height))
    }
}

public extension ToggleStyle where Self == NeumorphicSwitchToggleStyle {
    /// The default Neumorphic switch style.
    static var neumorphicSwitch: Self { .init() }
}

struct SwitchToggleStyleBox: View {
    @State var isEnabled: Bool = true
    var body: some View {
        VStack {
            Text("isEnabled: \(isEnabled ? "ON" : "OFF")")

            Toggle("isEnabled", isOn: $isEnabled)
                .switchToggleStyle(tint: .accentColor, height: 20)
            Toggle("isEnabled", isOn: $isEnabled)
                .toggleStyle(SoftSwitchToggleStyle(tintColor: .accentColor, offTintColor: Color.Neumorphic.main, mainColor: Color.Neumorphic.main, darkShadowColor: Color.Neumorphic.darkShadow, lightShadowColor: Color.Neumorphic.lightShadow, hideLabel: false))
            Toggle("isEnabled", isOn: $isEnabled)
                .toggleStyle(SoftDynamicToggleStyle(RoundedRectangle(cornerRadius: 10, style: .continuous), mainColor: Color.Neumorphic.main, textColor: Color.Neumorphic.secondary, darkShadowColor: Color.Neumorphic.darkShadow, lightShadowColor: Color.Neumorphic.lightShadow, pressedEffect: .hard, padding: 10))
        }
        .padding()
        .background(Color.Neumorphic.main)
    }
}

struct SwitchToggleStyleBox_Previews: PreviewProvider {
    static var previews: some View {
        SwitchToggleStyleBox()
    }
}
