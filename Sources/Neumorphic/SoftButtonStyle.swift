//
//  SoftButtonStyle.swift
//  Created by Costa Chung on 2/3/2020.
//  Copyright © 2020 Costa Chung. All rights reserved.
//  Neumorphism Soft UI

import SwiftUI

/// Visual treatment applied while a soft button is pressed.
public enum SoftButtonPressedEffect {
    /// Do not change the pressed surface.
    case none
    /// Flatten the surface while pressed.
    case flat
    /// Apply an inner shadow while pressed.
    case hard
}

/// A button style whose pressed appearance is driven by the button state.
public struct SoftDynamicButtonStyle<S: Shape>: ButtonStyle {

    var shape: S
    var mainColor: Color
    var textColor: Color
    var darkShadowColor: Color
    var lightShadowColor: Color
    var pressedEffect: SoftButtonPressedEffect
    var padding: CGFloat

    /// Creates a dynamic soft button style.
    public init(
        _ shape: S, mainColor: Color, textColor: Color, darkShadowColor: Color, lightShadowColor: Color,
        pressedEffect: SoftButtonPressedEffect, padding: CGFloat = 16
    ) {
        self.shape = shape
        self.mainColor = mainColor
        self.textColor = textColor
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.pressedEffect = pressedEffect
        self.padding = padding
    }

    /// Builds the button content for the current state.
    public func makeBody(configuration: Self.Configuration) -> some View {
        SoftDynamicButton(
            configuration: configuration, shape: shape, mainColor: mainColor, textColor: textColor,
            darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, pressedEffect: pressedEffect,
            padding: padding)
    }

    struct SoftDynamicButton: View {
        let configuration: ButtonStyle.Configuration

        var shape: S
        var mainColor: Color
        var textColor: Color
        var darkShadowColor: Color
        var lightShadowColor: Color
        var pressedEffect: SoftButtonPressedEffect
        var padding: CGFloat

        @Environment(\.isEnabled) private var isEnabled: Bool
        @Environment(\.accessibilityReduceMotion) private var reduceMotion

        var body: some View {
            configuration.label
                .foregroundColor(isEnabled ? textColor : textColor.opacity(0.55))
                .padding(padding)
                .scaleEffect(configuration.isPressed && !reduceMotion ? 0.97 : 1)
                .background(
                    ZStack {
                        if isEnabled {
                            if pressedEffect == .flat {
                                shape.stroke(darkShadowColor, lineWidth: configuration.isPressed ? 1 : 0)
                                    .opacity(configuration.isPressed ? 1 : 0)
                                shape.fill(mainColor)
                            } else if pressedEffect == .hard {
                                shape.fill(mainColor)
                                    .softInnerShadow(
                                        shape, darkShadow: darkShadowColor, lightShadow: lightShadowColor, spread: 0.15,
                                        radius: 3
                                    )
                                    .opacity(configuration.isPressed ? 1 : 0)
                            }
                            shape.fill(mainColor)
                                .softOuterShadow(
                                    darkShadow: darkShadowColor, lightShadow: lightShadowColor, offset: 6, radius: 3
                                )
                                .opacity(pressedEffect == .none ? 1 : (configuration.isPressed ? 0 : 1))
                        } else {
                            shape.stroke(darkShadowColor, lineWidth: 1)
                                .opacity(1)
                            shape.fill(mainColor)
                        }

                    }
                )
                .frame(minWidth: 44, minHeight: 44)
        }
    }

}

@available(*, deprecated, message: "Use SoftDynamicButtonStyle instead")
/// A soft button style with a fixed visual treatment.
public struct SoftButtonStyle<S: Shape>: ButtonStyle {

    var shape: S
    var mainColor: Color
    var textColor: Color
    var darkShadowColor: Color
    var lightShadowColor: Color

    /// Creates a fixed soft button style.
    public init(_ shape: S, mainColor: Color, textColor: Color, darkShadowColor: Color, lightShadowColor: Color) {
        self.shape = shape
        self.mainColor = mainColor
        self.textColor = textColor
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
    }

    /// Builds the button content for the current state.
    public func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            shape.fill(mainColor)
                .softInnerShadow(
                    shape, darkShadow: darkShadowColor, lightShadow: lightShadowColor, spread: 0.15, radius: 3
                )
                .opacity(configuration.isPressed ? 1 : 0)

            shape.fill(mainColor)
                .softOuterShadow(darkShadow: darkShadowColor, lightShadow: lightShadowColor, offset: 6, radius: 3)
                .opacity(configuration.isPressed ? 0 : 1)

            configuration.label
                .foregroundColor(textColor)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .modifier(SoftButtonPressScaleModifier(isPressed: configuration.isPressed))
        }
    }

}

private struct SoftButtonPressScaleModifier: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    let isPressed: Bool

    func body(content: Content) -> some View {
        content.scaleEffect(isPressed && !reduceMotion ? 0.97 : 1)
    }
}

public extension View {

    /// Applies a soft button style to the view.
    func softButtonStyle<S: Shape>(
        _ content: S, padding: CGFloat = 16, mainColor: Color = Color.Neumorphic.main,
        textColor: Color = Color.Neumorphic.secondary, darkShadowColor: Color = Color.Neumorphic.darkShadow,
        lightShadowColor: Color = Color.Neumorphic.lightShadow, pressedEffect: SoftButtonPressedEffect = .hard
    ) -> some View {
        self.buttonStyle(
            SoftDynamicButtonStyle(
                content, mainColor: mainColor, textColor: textColor, darkShadowColor: darkShadowColor,
                lightShadowColor: lightShadowColor, pressedEffect: pressedEffect, padding: padding))
    }

}

@available(*, deprecated, message: "Use the View-based softButtonStyle modifier.")
public extension Button {
    /// Compatibility wrapper for the original Button-only API.
    @MainActor
    func softButtonStyle<S: Shape>(
        _ content: S, padding: CGFloat = 16, mainColor: Color = Color.Neumorphic.main,
        textColor: Color = Color.Neumorphic.secondary, darkShadowColor: Color = Color.Neumorphic.darkShadow,
        lightShadowColor: Color = Color.Neumorphic.lightShadow, pressedEffect: SoftButtonPressedEffect = .hard
    ) -> some View {
        buttonStyle(
            SoftDynamicButtonStyle(
                content, mainColor: mainColor, textColor: textColor, darkShadowColor: darkShadowColor,
                lightShadowColor: lightShadowColor, pressedEffect: pressedEffect, padding: padding))
    }
}
