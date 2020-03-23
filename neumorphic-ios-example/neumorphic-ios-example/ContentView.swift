//
//  ContentView.swift
//  neumorphic-ios-example
//
//  Created by Costa Chung on 2/3/2020.
//  Copyright © 2020 Costa Chung. All rights reserved.

import SwiftUI
import Neumorphic

struct ContentView: View {

    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        let cornerRadius : CGFloat = 15
        Neumorphic.shared.colorScheme = colorScheme
        let mainColor = Neumorphic.shared.mainColor()
        let secondaryColor = Neumorphic.shared.secondaryColor()
        
        return ZStack {
            mainColor.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 30) {
                Text("Neumorphic Soft UI").font(.headline).foregroundColor(secondaryColor)
                //Create simple shapes with soft inner shadow
                HStack(spacing: 40) {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(mainColor).frame(width: 150, height: 150)
                        .softInnerShadow(RoundedRectangle(cornerRadius: cornerRadius))
                    
                    Circle().fill(mainColor).frame(width: 150, height: 150)
                        .softInnerShadow(Circle())
                }
                //You can customize shadow by changing its color, spread, and shadow radius.
                HStack(spacing: 40) {
                    ZStack {
                        Circle().fill(mainColor).frame(width: 150, height: 150)
                            .softInnerShadow(Circle(), spread: 0.6)
                        
                        Circle().fill(mainColor).frame(width: 80, height: 80)
                            .softOuterShadow(offset: 8, radius: 8)
                    }
                    ZStack {
                        Circle().fill(mainColor).frame(width: 150, height: 150)
                            .softOuterShadow()
                        
                        Circle().fill(mainColor).frame(width: 80, height: 80)
                            .softInnerShadow(Circle(), radius: 5)
                    }
                }
                //Rectanlges with soft outer shadow
                HStack(spacing: 30) {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(mainColor).frame(width: 90, height: 90)
                        .softOuterShadow()
                    
                    RoundedRectangle(cornerRadius: cornerRadius).fill(mainColor).frame(width: 90, height: 90)
                        .softInnerShadow(RoundedRectangle(cornerRadius: cornerRadius))
                    
                    Rectangle().fill(mainColor).frame(width: 90, height: 90)
                        .softOuterShadow()
                }
                
                //You can simply create soft button with softButtonStyle method.
                Button(action: {}) {
                    Text("Soft Button").fontWeight(.bold)
                }
                .softButtonStyle(RoundedRectangle(cornerRadius: cornerRadius))
                .frame(width: 340, height: 50)
                
                HStack(spacing: 30) {
                    //Circle Button
                    Button(action: {}) {
                        Image(systemName: "heart.fill")
                    }.softButtonStyle(Circle())
                        .frame(width: 50, height: 50)
                    
                    //Ellipse Button
                    Button(action: {}) {
                        Text("Thanks").fontWeight(.bold)
                    }.softButtonStyle(Ellipse())
                        .frame(width: 150, height: 50)
                    //Circle Button
                    Button(action: {}) {
                        Image(systemName: "heart.fill")
                    }.softButtonStyle(Circle(), mainColor: Color.red, textColor: Color.white, darkShadowColor: Color(rgb: 0x993333, alpha: 1), lightShadowColor:Color("redButtonLightShadow"))
                        .frame(width: 50, height: 50)
                    
                }
                 
                Text("Twitter @costachung").font(.footnote).foregroundColor(secondaryColor)
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           ContentView()
              .environment(\.colorScheme, .light)

           ContentView()
              .environment(\.colorScheme, .dark)
        }
    }
}



