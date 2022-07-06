//
//  SoftButtonDemoView.swift
//  neumorphic-examples
//
//  Created by Costa Chung on 10/8/2020.
//  Copyright © 2020 Costa Chung. All rights reserved.
//

import SwiftUI
import Neumorphic

struct SoftButtonDemoView: View {    
    var body: some View {
        return NavigationView {
            ZStack {
                Color.Neumorphic.main.edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack(spacing:25){

                        HStack(spacing:15) {
                            Button(action: {}) {
                                Text("Capsule")
                                    .fontWeight(.bold)
                            }.softButtonStyle(Capsule())
                            
                            Button(action: {}) {
                                Text("RoundedRectangle")
                                    .fontWeight(.bold)
                            }.softButtonStyle(RoundedRectangle(cornerRadius: 20))
                        }

                        HStack(spacing:15) {
                            Button(action: {}) {
                                Image(systemName: "heart.fill")
                            }.softButtonStyle(Circle())

                            Button(action: {}) {
                                Text("Ellipse").fontWeight(.bold)
                                    .frame(width: 150, height: 20)
                            }.softButtonStyle(Ellipse())
                            
                            Button(action: {}) {
                                Image(systemName: "heart.fill")
                            }.softButtonStyle(Circle(), mainColor: Color.red, textColor: Color.white, darkShadowColor: Color("redButtonDarkShadow"), lightShadowColor:Color("redButtonLightShadow"))
                        }
                        
                        Button(action: {}) {
                            Text("Custom Size")
                                .fontWeight(.bold)
                                .frame(width: 300, height: 20)
                        }
                        .softButtonStyle(Capsule(), padding: 15)
                        
                        
                        HStack {
                            Button(action: {}) {
                                Text("Padding").fontWeight(.bold)
                            }
                            .softButtonStyle(RoundedRectangle(cornerRadius: 20), padding: 10)
                            
                            Button(action: {}) {
                                Text("Disabled").fontWeight(.bold)
                            }
                            .softButtonStyle(RoundedRectangle(cornerRadius: 20), padding: 10)
                            .disabled(true)
                        }
                        
                        
                        Text("Pressed Effect").font(.headline).foregroundColor(Color.Neumorphic.secondary)
                            
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
                        

                        Text("ContextMenu").font(.headline).foregroundColor(Color.Neumorphic.secondary)
                        
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
                            Capsule().fill(Color.Neumorphic.main).softOuterShadow()
                        )
                        

                        
                        
                    }

                }
                .navigationBarTitle("Soft Button Demo")
            }
        }
    }
}

struct SoftButtonDemoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SoftButtonDemoView()
                .navigationViewStyle(StackNavigationViewStyle())
                .environment(\.colorScheme, .light)

            SoftButtonDemoView()
                .navigationViewStyle(StackNavigationViewStyle())
                .environment(\.colorScheme, .dark)
        }
    }
}
