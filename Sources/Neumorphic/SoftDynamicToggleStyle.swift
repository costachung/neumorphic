//
//  SwiftUIView.swift
//  
//
//  Created by Costa Chung on 11/12/2020.
//

import SwiftUI

extension Toggle {
    
    public func softToggleStyle<S : Shape>(_ content: S, padding : CGFloat = 16, mainColor : Color = Neumorphic.shared.mainColor(), textColor : Color = Neumorphic.shared.secondaryColor(), darkShadowColor: Color = Neumorphic.shared.darkShadowColor(), lightShadowColor: Color = Neumorphic.shared.lightShadowColor(), pressedEffect : SoftButtonPressedEffect = .hard) -> some View {
        self.toggleStyle(SoftDynamicToggleStyle(content, mainColor: mainColor, textColor: textColor, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, pressedEffect : pressedEffect, padding:padding))
    }
    
    public struct SoftDynamicToggleStyle<S: Shape> : ToggleStyle {
        
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
            configuration.label
                .foregroundColor(textColor)
                .padding(padding)
                .scaleEffect(configuration.isOn ? 0.97 : 1)
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
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        configuration.isOn = !configuration.isOn
                    }
                }
        }
        
        
    }
    
}
