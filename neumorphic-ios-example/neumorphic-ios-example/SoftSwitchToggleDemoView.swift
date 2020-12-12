//
//  SoftSwitchToggleDemoView.swift
//  neumorphic-ios-example
//
//  Created by Costa Chung on 12/12/2020.
//  Copyright © 2020 Costa Chung. All rights reserved.
//

import SwiftUI
import Neumorphic

extension Text {
    public func demoViewSectionTitle() -> some View {
        return self.font(.body)
            .fontWeight(.bold)
            .foregroundColor(Neumorphic.shared.secondaryColor())
    }
}

struct SoftSwitchToggleDemoView: View {

    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var toggleIsOn : Bool = false
    
    var body: some View {
        Neumorphic.shared.colorScheme = colorScheme
        return ZStack {
            Neumorphic.shared.mainColor().edgesIgnoringSafeArea(.all)
            VStack(spacing:8){
                Text("Demo")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("System Default Toggle Button")
                    .demoViewSectionTitle()
                
                //System Toggle Button
                HStack(spacing:15) {
                    Spacer()
                    Toggle("Toggle", isOn: $toggleIsOn)
                    .toggleStyle(SwitchToggleStyle(tint: .red))
                    .labelsHidden()
                    Spacer()
                }
                .padding()
                
                //softSwitchToggleStyle
                Text("Neumorphic")
                    .demoViewSectionTitle()
                Text("Soft Switch Toggle Style")
                    .demoViewSectionTitle()
                HStack(spacing:15) {
                    Spacer()
                    Toggle("Toggle", isOn: $toggleIsOn)
                    .softSwitchToggleStyle(tint: .red, labelsHidden: true)
                    Spacer()
                }
                .padding()
            }
            .padding()
        }
    }
    
}

struct SoftSwitchToggleDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SoftSwitchToggleDemoView()
            .environment(\.colorScheme, .light)
        
    }
}
