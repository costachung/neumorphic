//
//  SoftButtonDemoView.swift
//  neumorphic-ios-example
//
//  Created by Costa Chung on 10/8/2020.
//  Copyright © 2020 Costa Chung. All rights reserved.
//

import SwiftUI
import Neumorphic

struct SoftButtonDemoView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        Neumorphic.shared.colorScheme = colorScheme
        return NavigationView {
            ZStack {
                Neumorphic.shared.mainColor().edgesIgnoringSafeArea(.all)

                ScrollView {
                    Spacer(minLength: 15)
                    
                    HStack {
                        Button(action: {}) {
                            Text("Capsule").fontWeight(.bold)
                        }.softButtonStyle(Capsule())
                        .padding(10)
                        
                        Button(action: {}) {
                            Text("RoundedRectangle").fontWeight(.bold)
                        }.softButtonStyle(RoundedRectangle(cornerRadius: 20))
                        .padding(10)
                    }

                    HStack {
                        Button(action: {}) {
                            Image(systemName: "heart.fill")
                        }.softButtonStyle(Circle())
                        .padding(10)

                        Button(action: {}) {
                            Text("Ellipse").fontWeight(.bold).frame(width: 150, height: 20)
                        }.softButtonStyle(Ellipse())
                        .padding(10)
                        
                        Button(action: {}) {
                            Image(systemName: "heart.fill")
                        }.softButtonStyle(Circle(), mainColor: Color.red, textColor: Color.white, darkShadowColor: Color(rgb: 0x993333, alpha: 1), lightShadowColor:Color("redButtonLightShadow"))
                        .padding(10)
                    }
                    
                    Spacer(minLength: 95)
                    
                    Text("Pressed Effect").font(.headline).foregroundColor(Neumorphic.shared.secondaryColor())
                        
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Text(".none").fontWeight(.bold)
                        }.softButtonStyle(Capsule(), pressedEffect: .none)
                        Spacer()
                        Button(action: {}) {
                            Text(".flat").fontWeight(.bold)
                        }.softButtonStyle(Capsule(), pressedEffect: .flat)
                        Spacer()
                        Button(action: {}) {
                            Text(".hard").fontWeight(.bold)
                        }.softButtonStyle(Capsule(), pressedEffect: .hard)
                        Spacer()
                    }
                    
                    Spacer(minLength: 95)

                    Text("ContextMenu").font(.headline).foregroundColor(Neumorphic.shared.secondaryColor())
                    
                    Button(action: {}) {
                        Text("Button").fontWeight(.bold)
                    }
                    .softButtonStyle(Capsule(), pressedEffect: .none)
                    .contentShape(Capsule())
                    .contextMenu(
                        ContextMenu(menuItems: {
                            Text("Menu Item 1")
                            Text("Menu Item 2")
                        }
                    ))
                    .background(
                        Capsule().fill(Neumorphic.shared.mainColor()).softOuterShadow()
                    )
                    
                    
                
                    
                }.navigationBarTitle("Soft Button Demo")
            }
        }
    }
}

struct SoftButtonDemoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SoftButtonDemoView()
              .environment(\.colorScheme, .light)

            SoftButtonDemoView()
              .environment(\.colorScheme, .dark)
        }
    }
}
