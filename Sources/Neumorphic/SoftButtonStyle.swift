//
//  SoftButtonStyle.swift
//  Created by Costa Chung on 2/3/2020.
//  Copyright © 2020 Costa Chung. All rights reserved.
//  Neumorphism Soft UI

import SwiftUI

public enum SoftButtonPressedEffect {
    case none
    case flat
    case hard
}

public struct SoftDynamicButtonStyle<S: Shape> : ButtonStyle {

    var shape: S
    var mainColor : Color
    var textColor : Color
    var darkShadowColor : Color
    var lightShadowColor : Color
    var pressedEffect : SoftButtonPressedEffect
    
    public init(_ shape: S, mainColor : Color, textColor : Color, darkShadowColor: Color, lightShadowColor: Color, pressedEffect : SoftButtonPressedEffect) {
        self.shape = shape
        self.mainColor = mainColor
        self.textColor = textColor
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.pressedEffect = pressedEffect
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .foregroundColor(textColor)
                .padding()
                .scaleEffect(configuration.isPressed ? 0.97 : 1)
                .background(
                    ZStack{
                        if pressedEffect == .flat {
                            shape.stroke(darkShadowColor, lineWidth : configuration.isPressed ? 1 : 0)
                            .opacity(configuration.isPressed ? 1 : 0)
                            shape.fill(mainColor)
                        }
                        else if pressedEffect == .hard {
                            shape.fill(mainColor)
                                .softInnerShadow(shape, darkShadow: darkShadowColor, lightShadow: lightShadowColor, spread: 0.15, radius: 3)
                                .opacity(configuration.isPressed ? 1 : 0)
                        }
                        
                        shape.fill(mainColor)
                            .softOuterShadow(darkShadow: darkShadowColor, lightShadow: lightShadowColor, offset: 6, radius: 3)
                            .opacity(pressedEffect == .none ? 1 : (configuration.isPressed ? 0 : 1) )
                    }
                )
    }
    
}

@available(*, deprecated, message: "Use SoftDynamicButtonStyle instead")
public struct SoftButtonStyle<S: Shape> : ButtonStyle {

    var shape: S
    var mainColor : Color
    var textColor : Color
    var darkShadowColor : Color
    var lightShadowColor : Color
    
    public init(_ shape: S, mainColor : Color, textColor : Color, darkShadowColor: Color, lightShadowColor: Color) {
        self.shape = shape
        self.mainColor = mainColor
        self.textColor = textColor
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
                shape.fill(mainColor)
                    .softInnerShadow(shape, darkShadow: darkShadowColor, lightShadow: lightShadowColor, spread: 0.15, radius: 3)
                    .opacity(configuration.isPressed ? 1 : 0)
            
                shape.fill(mainColor)
                    .softOuterShadow(darkShadow: darkShadowColor, lightShadow: lightShadowColor, offset: 6, radius: 3)
                    .opacity(configuration.isPressed ? 0 : 1)

            configuration.label
                .foregroundColor(textColor)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .scaleEffect(configuration.isPressed ? 0.97 : 1)
        }
    }
    
}


extension Button {

    public func softButtonStyle<S : Shape>(_ content: S, mainColor : Color = Neumorphic.shared.mainColor(), textColor : Color = Neumorphic.shared.secondaryColor(), darkShadowColor: Color = Neumorphic.shared.darkShadowColor(), lightShadowColor: Color = Neumorphic.shared.lightShadowColor(), pressedEffect : SoftButtonPressedEffect = .hard) -> some View {
        self.buttonStyle(SoftDynamicButtonStyle(content, mainColor: mainColor, textColor: textColor, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, pressedEffect : pressedEffect))
    }

    
}

