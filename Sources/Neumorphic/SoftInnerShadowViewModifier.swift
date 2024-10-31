//
//  SoftInnerShadowModifier.swift
//  Created by Costa Chung on 18/3/2020.
//  Copyright © 2020 Costa Chung. All rights reserved.
//  Neumorphism Soft UI
//

import SwiftUI

private struct SoftInnerShadowViewModifier<S: Shape> : ViewModifier {
    var shape: S
    var darkShadowColor : Color = .black
    var lightShadowColor : Color = .white
    var spread: CGFloat = 0.5    //The value of spread is between 0 to 1. Higher value makes the shadow look more intense.
    var radius: CGFloat = 10
    
    init(shape: S, darkShadowColor: Color, lightShadowColor: Color, spread: CGFloat, radius:CGFloat) {
        self.shape = shape
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.spread = spread
        self.radius = radius
    }

    fileprivate func strokeLineWidth(_ geo: GeometryProxy) -> CGFloat {
        return geo.size.width * 0.10
    }
    
    fileprivate func strokeLineScale(_ geo: GeometryProxy) -> CGFloat {
        let lineWidth = strokeLineWidth(geo)
        return geo.size.width / CGFloat(geo.size.width - lineWidth)
    }
    
    fileprivate func shadowOffset(_ geo: GeometryProxy) -> CGFloat {
        return (geo.size.width <= geo.size.height ? geo.size.width : geo.size.height) * 0.5 * min(max(spread, 0), 1)
    }
    

    fileprivate func addSoftInnerShadow(_ content: SoftInnerShadowViewModifier.Content) -> some View {
        return GeometryReader { geo in
        #if os(macOS)
            //The mask on macOS doesn't work properly with shadow. The shadow disappear after calling the mask modifier.
            //Workaround: Use blur instead of shadow. 
            self.shape.fill(self.lightShadowColor)
                .inverseMask(
                    self.shape
                        .offset(x: -self.shadowOffset(geo), y: -self.shadowOffset(geo))
                )
                .blur(radius: self.radius)
                .mask(
                    self.shape
                )
                .overlay(
                    self.shape
                        .fill(self.darkShadowColor)
                        .inverseMask(
                            self.shape
                                .offset(x: self.shadowOffset(geo), y: self.shadowOffset(geo))
                        )
                        .blur(radius: self.radius)
                )
                .mask(
                    self.shape
                )
        #else
            // iOS
            self.shape.fill(self.lightShadowColor)
                .inverseMask(
                    self.shape
                        .offset(x: -self.shadowOffset(geo), y: -self.shadowOffset(geo))
                )
                .offset(x: self.shadowOffset(geo) , y: self.shadowOffset(geo))
                .blur(radius: self.radius)
                .shadow(color: self.lightShadowColor, radius: self.radius, x: -self.shadowOffset(geo)/2, y: -self.shadowOffset(geo)/2 )
                .mask(
                    self.shape
                )
                .overlay(
                    self.shape
                        .fill(self.darkShadowColor)
                        .inverseMask(
                            self.shape
                                .offset(x: self.shadowOffset(geo), y: self.shadowOffset(geo))
                        )
                        .offset(x: -self.shadowOffset(geo) , y: -self.shadowOffset(geo))
                        .blur(radius: self.radius)
                        .shadow(color: self.darkShadowColor, radius: self.radius, x: self.shadowOffset(geo)/2, y: self.shadowOffset(geo)/2 )
                )
                .mask(
                    self.shape
                )
            #endif
            
        }
    }

    func body(content: Content) -> some View {
        content.overlay(
            addSoftInnerShadow(content)
        )
    }
}


//For more readable, we extend the View and create a softInnerShadow function.
extension View {

    public func softInnerShadow<S : Shape>(_ content: S, darkShadow: Color = Color.Neumorphic.darkShadow, lightShadow: Color = Color.Neumorphic.lightShadow, spread: CGFloat = 0.5, radius: CGFloat = 10) -> some View {
        modifier(
            SoftInnerShadowViewModifier(shape: content, darkShadowColor: darkShadow, lightShadowColor: lightShadow, spread: spread, radius: radius)
        )
    }
    
}
