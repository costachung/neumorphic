//
//  SwiftUIView.swift
//  
//
//  Created by Costa Chung on 11/12/2020.
//

import SwiftUI

public struct SoftDynamicToggleStyle<S: Shape> : ToggleStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
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
            .opacity(isEnabled ? 1 : 0.3)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    configuration.isOn = !configuration.isOn
                }
            }
    }
}



public struct SoftSwitchToggleStyle : ToggleStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    var tintColor : Color
    var offTintColor : Color
    
    var mainColor : Color
    var darkShadowColor : Color
    var lightShadowColor : Color
    
    var hideLabel : Bool
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
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
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
            }
            .opacity(isEnabled ? 1 : 0.3)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    configuration.isOn.toggle()
                }
            }
        }
    }
    
}




extension Toggle {
    
    public func softToggleStyle<S : Shape>(_ content: S, padding : CGFloat = 16, mainColor : Color = Color.Neumorphic.main, textColor : Color = Color.Neumorphic.secondary, darkShadowColor: Color = Color.Neumorphic.darkShadow, lightShadowColor: Color = Color.Neumorphic.lightShadow, pressedEffect : SoftButtonPressedEffect = .hard) -> some View {
        self.toggleStyle(SoftDynamicToggleStyle(content, mainColor: mainColor, textColor: textColor, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, pressedEffect : pressedEffect, padding:padding))
    }

    public func softSwitchToggleStyle(tint: Color = .green, offTint: Color = Color.Neumorphic.main, mainColor : Color = Color.Neumorphic.main, darkShadowColor: Color = Color.Neumorphic.darkShadow, lightShadowColor: Color = Color.Neumorphic.lightShadow, labelsHidden : Bool = false) -> some View {
        return self.toggleStyle(SoftSwitchToggleStyle(tintColor: tint, offTintColor: offTint, mainColor: mainColor, darkShadowColor: darkShadowColor, lightShadowColor: lightShadowColor, hideLabel: labelsHidden))
    }
    
}



