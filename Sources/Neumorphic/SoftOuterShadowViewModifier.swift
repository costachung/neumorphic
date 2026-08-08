//
//  SoftOuterShadow.swift
//  Created by Costa Chung on 2/3/2020.
//  Copyright © 2020 Costa Chung. All rights reserved.
//  Neumorphism Soft UI

import SwiftUI

private struct SoftOuterShadowViewModifier: ViewModifier {
    var lightShadowColor : Color
    var darkShadowColor : Color
    var offset: CGFloat
    var radius : CGFloat

    init(darkShadowColor: Color, lightShadowColor: Color, offset: CGFloat, radius: CGFloat) {
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.offset = offset
        self.radius = max(radius, 0)
    }

    func body(content: Content) -> some View {
        content
        .shadow(color: darkShadowColor, radius: radius, x: offset, y: offset)
        .shadow(color: lightShadowColor, radius: radius, x: -offset, y: -offset)
    }

}

extension View {

    /// Applies a soft outer shadow to the view.
    public func softOuterShadow(darkShadow: Color = Color.Neumorphic.darkShadow, lightShadow: Color = Color.Neumorphic.lightShadow, offset: CGFloat = 6, radius:CGFloat = 3) -> some View {
        modifier(SoftOuterShadowViewModifier(darkShadowColor: darkShadow, lightShadowColor: lightShadow, offset: offset, radius: radius))
    }

}
