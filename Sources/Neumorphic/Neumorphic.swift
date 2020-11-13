//
//  Neumorphic.swift
//  Created by Costa Chung on 2/3/2020.
//  Copyright © 2020 Costa Chung. All rights reserved.
//  Neumorphism Soft UI

import SwiftUI

public struct Neumorphic {

    public static let defaultMainColor = Color(red: 0.925, green: 0.941, blue: 0.953, opacity: 1.000)
    public static let defaultSecondaryColor = Color(red: 0.482, green: 0.502, blue: 0.549, opacity: 1.000)
    public static let defaultLightShadowColor = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 1.000)
    public static let defaultDarkShadowColor = Color(red: 0.820, green: 0.851, blue: 0.902, opacity: 1.000)

    public static let darkThemeMainColor = Color(red: 0.188, green: 0.192, blue: 0.208, opacity: 1.000)
    public static let darkThemeSecondaryColor = Color(red: 0.910, green: 0.910, blue: 0.910, opacity: 1.000)
    public static let darkThemeLightShadowColor = Color(red: 0.243, green: 0.247, blue: 0.275, opacity: 1.000)
    public static let darkThemeDarkShadowColor = Color(red: 0.137, green: 0.137, blue: 0.137, opacity: 1.000)
    
        
    public static var shared = Neumorphic()
    
    public var colorScheme : ColorScheme = .light
    
    public func mainColor() -> Color {
        colorScheme == .light ? Neumorphic.defaultMainColor : Neumorphic.darkThemeMainColor
    }
    
    public func secondaryColor() -> Color {
        colorScheme == .light ? Neumorphic.defaultSecondaryColor : Neumorphic.darkThemeSecondaryColor
    }
    
    public func lightShadowColor() -> Color {
        colorScheme == .light ? Neumorphic.defaultLightShadowColor : Neumorphic.darkThemeLightShadowColor
    }
    
    public func darkShadowColor() -> Color {
        colorScheme == .light ? Neumorphic.defaultDarkShadowColor : Neumorphic.darkThemeDarkShadowColor
    }
    
    
}




