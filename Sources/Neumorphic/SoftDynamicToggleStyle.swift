//
//  SwiftUIView.swift
//
//
//  Created by Costa Chung on 11/12/2020.
//

import SwiftUI

/// A toggle style that uses a shape and soft shadows to show state.
public struct SoftDynamicToggleStyle<S: Shape> : ToggleStyle {

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var shape: S
    var mainColor : Color
    var textColor : Color
    var darkShadowColor : Color
    var lightShadowColor : Color
    var pressedEffect : SoftButtonPressedEffect
    var padding : CGFloat

    /// Creates a shape-based soft toggle style.
    public init(_ shape: S, mainColor : Color, textColor : Color, darkShadowColor: Color, lightShadowColor: Color, pressedEffect : SoftButtonPressedEffect, padding : CGFloat = 16) {
        self.shape = shape
        self.mainColor = mainColor
        self.textColor = textColor
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.pressedEffect = pressedEffect
        self.padding = padding
    }

    /// Builds the toggle content for the current state.
    public func makeBody(configuration: Self.Configuration) -> some View {
        Button {
            withAnimation(reduceMotion ? nil : .easeInOut(duration: 0.2)) {
                configuration.isOn.toggle()
            }
        } label: {
            configuration.label
                .foregroundColor(textColor)
                .padding(padding)
                .scaleEffect(configuration.isOn && !reduceMotion ? 0.97 : 1)
                .background(
                    ZStack{
                        if pressedEffect == .flat {
                            shape
                                .stroke(darkShadowColor, lineWidth : configuration.isOn ? 1 : 0)
                                .opacity(configuration.isOn ? 1 : 0)
                            shape
                                .fill(mainColor)
                        }
                        else if pressedEffect == .hard {
                            shape
                                .fill(mainColor)
                                .softInnerShadow(shape, darkShadow: darkShadowColor, lightShadow: lightShadowColor, spread: 0.15, radius: 3)
                                .opacity(configuration.isOn ? 1 : 0)
                        }

                        shape
                            .fill(mainColor)
                            .softOuterShadow(darkShadow: darkShadowColor, lightShadow: lightShadowColor, offset: 6, radius: 3)
                            .opacity(pressedEffect == .none ? 1 : (configuration.isOn ? 0 : 1) )
                    }
                )
                .opacity(isEnabled ? 1 : 0.4)
        }
        .buttonStyle(.plain)
        .stateAccessibilityValue(configuration.isOn)
        .frame(minWidth: 44, minHeight: 44)
    }

}



/// A horizontal switch-style toggle with soft shadows.
public struct SoftSwitchToggleStyle : ToggleStyle {

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var tintColor : Color
    var offTintColor : Color

    var mainColor : Color
    var darkShadowColor : Color
    var lightShadowColor : Color

    var hideLabel : Bool

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
                        .font(.body)
                    Spacer()
                }
                ZStack {
                    Capsule()
                        .fill(mainColor)
                        .softOuterShadow()
                        .frame(width: 75, height: 45)

                    Capsule()
                        .fill(configuration.isOn ? tintColor : offTintColor)
                        .softInnerShadow(Capsule(), darkShadow: configuration.isOn ? tintColor : darkShadowColor, lightShadow: configuration.isOn ? tintColor : lightShadowColor, spread: 0.35, radius: 3)
                        .frame(width: 70, height: 40)

                    Circle()
                        .fill(mainColor)
                        .softOuterShadow(darkShadow: darkShadowColor, lightShadow: lightShadowColor, offset: 2, radius: 1)
                        .frame(width: 30, height: 30)
                        .offset(x: configuration.isOn ? 15 : -15)
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
    /// Applies a shape-based soft toggle style.
    func softToggleStyle<S : Shape>(_ content: S, padding : CGFloat = 16, mainColor : Color = Color.Neumorphic.main, textColor : Color = Color.Neumorphic.secondary, darkShadowColor: Color = Color.Neumorphic.darkShadow, lightShadowColor: Color = Color.Neumorphic.lightShadow, pressedEffect : SoftButtonPressedEffect = .hard) -> some View {
        self.toggleStyle(SoftDynamicToggleStyle(content, mainColor: mainColor, textColor: textColor, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, pressedEffect : pressedEffect, padding:padding))
    }

    /// Applies a soft switch toggle style.
    func softSwitchToggleStyle(tint: Color = .green, offTint: Color = Color.Neumorphic.main, mainColor : Color = Color.Neumorphic.main, darkShadowColor: Color = Color.Neumorphic.darkShadow, lightShadowColor: Color = Color.Neumorphic.lightShadow, labelsHidden : Bool = false) -> some View {
        self.toggleStyle(SoftSwitchToggleStyle(tintColor: tint, offTintColor: offTint, mainColor: mainColor, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, hideLabel: labelsHidden))
    }

}

@available(*, deprecated, message: "Use the View-based softToggleStyle modifier.")
public extension Toggle {
    /// Compatibility wrapper for the original Toggle-only API.
    @MainActor
    func softToggleStyle<S: Shape>(_ content: S, padding: CGFloat = 16, mainColor: Color = Color.Neumorphic.main, textColor: Color = Color.Neumorphic.secondary, darkShadowColor: Color = Color.Neumorphic.darkShadow, lightShadowColor: Color = Color.Neumorphic.lightShadow, pressedEffect: SoftButtonPressedEffect = .hard) -> some View {
        toggleStyle(SoftDynamicToggleStyle(content, mainColor: mainColor, textColor: textColor, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, pressedEffect: pressedEffect, padding: padding))
    }

    /// Compatibility wrapper for the original switch toggle API.
    @MainActor
    func softSwitchToggleStyle(tint: Color = .green, offTint: Color = Color.Neumorphic.main, mainColor: Color = Color.Neumorphic.main, darkShadowColor: Color = Color.Neumorphic.darkShadow, lightShadowColor: Color = Color.Neumorphic.lightShadow, labelsHidden: Bool = false) -> some View {
        toggleStyle(SoftSwitchToggleStyle(tintColor: tint, offTintColor: offTint, mainColor: mainColor, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, hideLabel: labelsHidden))
    }
}
