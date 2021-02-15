//
//  ContentView.swift
//  mac-example
//
//  Created by Costa Chung on 14/2/2021.
//  Copyright © 2021 Costa Chung. All rights reserved.
//

import SwiftUI
import Neumorphic

struct ContentView: View {

    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var toggleIsOn : Bool = false
    
    var body: some View {
        return ZStack {
            Color.Neumorphic.main.ignoresSafeArea(.all)
            VStack() {
                HStack(spacing: 16) {
                    Toggle(isOn: $toggleIsOn, label: {
                            if toggleIsOn {
                                Image(systemName: "stop.fill")
                                    .font(.title)
                            }
                            else{
                                Image(systemName: "play.fill")
                                    .font(.title)
                            }
                        })
                        .softToggleStyle(Circle(), padding: 20)
                    
                    Toggle("Toggle", isOn: $toggleIsOn)
                      .softSwitchToggleStyle(tint: .green, labelsHidden: true)
                    
                    Button(action: {}) {
                        Text("Soft Button").fontWeight(.bold)
                    }
                    .softButtonStyle(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
                
                HStack(spacing: 16) {
                      Circle()
                        .fill(Color.Neumorphic.main)
                        .softOuterShadow()
                      Circle()
                        .fill(Color.Neumorphic.main)
                        .softInnerShadow(Circle())
                }
                .padding()
                
                HStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.Neumorphic.main)
                        .softOuterShadow()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.Neumorphic.main)
                        .softInnerShadow(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
            }
            .frame(width:500)
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
