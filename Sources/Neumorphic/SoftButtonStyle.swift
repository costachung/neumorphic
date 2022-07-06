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
    var padding : CGFloat
    
    public init(_ shape: S, mainColor : Color, textColor : Color, darkShadowColor: Color, lightShadowColor: Color, pressedEffect : SoftButtonPressedEffect, padding : CGFloat = 16) {
        self.shape = shape
        self.mainColor = mainColor
        self.textColor = textColor
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.pressedEffect = pressedEffect
        self.padding = padding
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SoftDynamicButton(configuration: configuration, shape: shape, mainColor: mainColor, textColor: textColor, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, pressedEffect: pressedEffect, padding: padding)
    }

    struct SoftDynamicButton: View {
        let configuration: ButtonStyle.Configuration
        
        var shape: S
        var mainColor : Color
        var textColor : Color
        var darkShadowColor : Color
        var lightShadowColor : Color
        var pressedEffect : SoftButtonPressedEffect
        var padding : CGFloat
        
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            configuration.label
                .foregroundColor(isEnabled ? textColor : darkShadowColor)
                .padding(padding)
                .scaleEffect(configuration.isPressed ? 0.97 : 1)
                .background(
                    ZStack{
                        if isEnabled {
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
                        }else{
                            shape.stroke(darkShadowColor, lineWidth : 1)
                            .opacity(1)
                            shape.fill(mainColor)
                        }
                        
                        
                        
                    }
                )
        }
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

    public func softButtonStyle<S : Shape>(_ content: S, padding : CGFloat = 16, mainColor : Color = Color.Neumorphic.main, textColor : Color = Color.Neumorphic.secondary, darkShadowColor: Color = Color.Neumorphic.darkShadow, lightShadowColor: Color = Color.Neumorphic.lightShadow, pressedEffect : SoftButtonPressedEffect = .hard) -> some View {
        self.buttonStyle(SoftDynamicButtonStyle(content, mainColor: mainColor, textColor: textColor, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, pressedEffect : pressedEffect, padding:padding))
    }

    
}

