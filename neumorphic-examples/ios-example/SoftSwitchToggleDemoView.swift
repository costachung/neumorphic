//
//  SoftSwitchToggleDemoView.swift
//  neumorphic-examples
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
            .foregroundColor(Color.Neumorphic.secondary)
    }
}

struct SoftSwitchToggleDemoView: View {
    @State var toggleIsOn : Bool = false
    
    @ViewBuilder
    fileprivate func demoView() -> some View {
        VStack{
            HStack {
                Text("System Default Toggle")
                    .demoViewSectionTitle()
            }
            //System Toggle Button
            HStack {
                Spacer()
                VStack{
                    Toggle("Toggle", isOn: $toggleIsOn)
                        .toggleStyle(SwitchToggleStyle(tint: .red))
                        .labelsHidden()
                    Text("Enabled")
                }
                Spacer()
                VStack{
                    Toggle("Toggle", isOn: $toggleIsOn)
                        .toggleStyle(SwitchToggleStyle(tint: .red))
                        .labelsHidden()
                        .disabled(true)
                    Text("Disabled")
                }
                Spacer()
            }
            .padding()

            //softSwitchToggleStyle
            VStack {
                Text("Neumorphic")
                    .demoViewSectionTitle()
                Text("Soft Switch Toggle Style")
                    .demoViewSectionTitle()
                softTogglePairView(tint: .gray)
                softTogglePairView(tint: .green)
                softTogglePairView(tint: .blue)
                softTogglePairView(tint: .red)
            }
            .padding()
        }
        .padding()
    }
    
    @ViewBuilder
    fileprivate func softTogglePairView(tint: Color = .green) -> some View {
        HStack(spacing:15) {
            Spacer()
            VStack{
                Toggle("Toggle", isOn: $toggleIsOn)
                    .softSwitchToggleStyle(tint: tint, labelsHidden: true)
                Text("Enabled")
            }
            Spacer()
            VStack{
                Toggle("Toggle", isOn: $toggleIsOn)
                    .softSwitchToggleStyle(tint: tint, labelsHidden: true)
                    .disabled(true)
                Text("Disabled")
            }
            Spacer()
        }
    }
    
    var body: some View {
        ZStack {
            Color.Neumorphic.main.edgesIgnoringSafeArea(.all)
            NavigationView {
                ScrollView {
                    demoView()
                }
                .navigationTitle("SoftSwitchToggle")
                .padding()
            }
        }
    }
    
}

struct SoftSwitchToggleDemoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SoftSwitchToggleDemoView()
                .environment(\.colorScheme, .light)
            
            SoftSwitchToggleDemoView()
                .environment(\.colorScheme, .dark)
        }
        
    }
}
