//
//  ContentView.swift
//  neumorphic-examples
//

import SwiftUI
import Neumorphic

struct ExampleShowcaseView: View {
    var body: some View {
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    Text("Neumorphic Examples")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(Color.Neumorphic.secondary)
                    DemoButtonsView()
                    DemoTogglesView()
                    DemoSwitchesView()
                    DemoCommonControlsView()
                    DemoSelectionControlsView()
                    DemoNavigationControlsView()
                    DemoShadowsView()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct DemoCommonControlsView: View {
    @State private var sliderValue = 65.0
    @State private var name = ""
    @State private var mode = "Light"

    var body: some View {
        DemoSection("Common Controls") {
            DemoLabeledControl("Slider") {
                NeumorphicSlider(value: $sliderValue, in: 0...100, step: 1, tint: .accentColor)
                    .frame(width: 220)
            }
            DemoLabeledControl("TextField") {
                NeumorphicTextField("Name", text: $name)
                    .frame(width: 220)
            }
            DemoLabeledControl("ProgressView") {
                NeumorphicProgressView(value: 0.65, tint: .green)
                    .frame(width: 220)
            }
            DemoLabeledControl("Picker") {
                NeumorphicPicker(selection: $mode, options: ["Light", "Dark"])
                    .frame(width: 220)
            }
        }
    }
}

private struct DemoSelectionControlsView: View {
    @State private var quantity = 2
    @State private var remember = true
    @State private var choice = "Light"

    var body: some View {
        DemoSection("Selection & Containers") {
            DemoLabeledControl("Stepper") { NeumorphicStepper("Quantity", value: $quantity, in: 0...10) }
            DemoLabeledControl("Checkbox") { NeumorphicCheckbox("Remember me", isOn: $remember) }
            VStack(alignment: .leading, spacing: 8) {
                NeumorphicRadio("Light", value: "Light", selection: $choice)
                NeumorphicRadio("Dark", value: "Dark", selection: $choice)
            }
            .neumorphicCard(padding: 14)
        }
    }
}

private struct DemoNavigationControlsView: View {
    @State private var date = Date()
    @State private var mode = "Light"
    @State private var expanded = true

    var body: some View {
        DemoSection("Navigation & Feedback") {
            DemoLabeledControl("DatePicker") { NeumorphicDatePicker("Start", selection: $date, displayedComponents: .date) }
            DemoLabeledControl("Menu") { NeumorphicMenu("Mode", selection: $mode, options: ["Light", "Dark"]) }
            NeumorphicDisclosureGroup("Details", isExpanded: $expanded) {
                Text("Expandable content")
                    .foregroundColor(Color.Neumorphic.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 16) {
                DemoLabeledControl("Link") { NeumorphicLink("Website", destination: URL(string: "https://example.com")!) }
                DemoLabeledControl("Circular") { NeumorphicCircularProgressView(value: 0.65, tint: .green) }
            }
        }
    }
}

private struct DemoLabeledControl<Content: View>: View {
    let title: String
    let content: Content

    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 8) {
            content
            Text(title)
                .font(.caption)
                .foregroundColor(Color.Neumorphic.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

private struct DemoSection<Content: View>: View {
    let title: String
    let content: Content

    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.Neumorphic.secondary)
            content
        }
    }
}

private struct DemoButtonsView: View {
    var body: some View {
        DemoSection("Buttons") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 115), spacing: 16)], spacing: 18) {
                DemoLabeledControl("Capsule") { Button("Button", action: {}).softButtonStyle(Capsule()) }
                DemoLabeledControl("Rounded Rectangle") { Button("Button", action: {}).softButtonStyle(RoundedRectangle(cornerRadius: 20)) }
                DemoLabeledControl("Ellipse") { Button("Button", action: {}).softButtonStyle(Ellipse()) }
                DemoLabeledControl("Circle") {
                    Button(action: {}) { Image(systemName: "heart.fill") }
                        .softButtonStyle(Circle())
                }
            }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 115), spacing: 16)], spacing: 18) {
                DemoLabeledControl("Custom Color") {
                    Button(action: {}) { Image(systemName: "heart.fill") }
                        .softButtonStyle(Circle(), mainColor: .red, textColor: .white)
                }
                DemoLabeledControl("Custom Size") {
                    Button("Button", action: {}).softButtonStyle(Capsule(), padding: 15)
                        .frame(width: 150)
                }
                DemoLabeledControl("Padding") {
                    Button("Button", action: {}).softButtonStyle(RoundedRectangle(cornerRadius: 20), padding: 10)
                }
                DemoLabeledControl("Disabled") {
                    Button("Button", action: {}).softButtonStyle(RoundedRectangle(cornerRadius: 20), padding: 10).disabled(true)
                }
            }
            Text("Pressed Effect").font(.subheadline).foregroundColor(Color.Neumorphic.secondary)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 115), spacing: 16)], spacing: 18) {
                DemoLabeledControl("None") { Button("Button", action: {}).softButtonStyle(Capsule(), pressedEffect: .none) }
                DemoLabeledControl("Flat") { Button("Button", action: {}).softButtonStyle(Capsule(), pressedEffect: .flat) }
                DemoLabeledControl("Hard") { Button("Button", action: {}).softButtonStyle(Capsule(), pressedEffect: .hard) }
            }
            DemoLabeledControl("Context Menu") {
                Button("Button", action: {}).softButtonStyle(Capsule(), pressedEffect: .none)
                    .contextMenu { Text("Menu Item 1"); Text("Menu Item 2") }
            }
        }
    }
}

private struct DemoTogglesView: View {
    @State private var isOn = false

    var body: some View {
        DemoSection("Toggles") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 115), spacing: 16)], spacing: 18) {
                DemoLabeledControl("System Default") { Toggle("Toggle", isOn: $isOn).toggleStyle(.switch) }
                DemoLabeledControl("Rectangle") { Toggle("Rect", isOn: $isOn).softToggleStyle(Rectangle()) }
                DemoLabeledControl("Rectangle Flat") { Toggle("Rect", isOn: $isOn).softToggleStyle(Rectangle(), pressedEffect: .flat) }
            }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 115), spacing: 16)], spacing: 18) {
                DemoLabeledControl("Rounded Rectangle") { Toggle("Rounded", isOn: $isOn).softToggleStyle(RoundedRectangle(cornerRadius: 8)) }
                DemoLabeledControl("Rounded Flat") { Toggle("Rounded", isOn: $isOn).softToggleStyle(RoundedRectangle(cornerRadius: 8), pressedEffect: .flat) }
                DemoLabeledControl("Capsule") { Toggle("Capsule", isOn: $isOn).softToggleStyle(Capsule()) }
                DemoLabeledControl("Capsule Flat") { Toggle("Capsule", isOn: $isOn).softToggleStyle(Capsule(), pressedEffect: .flat) }
            }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 115), spacing: 16)], spacing: 18) {
                DemoLabeledControl("Circle") { Toggle(isOn: $isOn) { Image(systemName: isOn ? "stop.fill" : "play.fill") }.softToggleStyle(Circle(), padding: 20) }
                DemoLabeledControl("Circle Flat") { Toggle(isOn: $isOn) { Image(systemName: isOn ? "stop.fill" : "play.fill") }.softToggleStyle(Circle(), padding: 20, pressedEffect: .flat) }
            }
        }
    }
}

private struct DemoSwitchesView: View {
    @State private var isOn = false

    var body: some View {
        DemoSection("Switches") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 115), spacing: 16)], spacing: 18) {
                DemoLabeledControl("System Enabled") { Toggle("Toggle", isOn: $isOn).toggleStyle(.switch).labelsHidden() }
                DemoLabeledControl("System Disabled") { Toggle("Toggle", isOn: $isOn).toggleStyle(.switch).labelsHidden().disabled(true) }
                DemoLabeledControl("Neumorphic Green") { Toggle("Toggle", isOn: $isOn).switchToggleStyle(tint: .green, labelsHidden: true) }
                DemoLabeledControl("Neumorphic Blue") { Toggle("Toggle", isOn: $isOn).switchToggleStyle(tint: .blue, labelsHidden: true) }
                DemoLabeledControl("Neumorphic Disabled") { Toggle("Toggle", isOn: $isOn).switchToggleStyle(tint: .red, labelsHidden: true).disabled(true) }
            }
        }
    }
}

private struct DemoShadowsView: View {
    private let size: CGFloat = 120
    private let main = Color.Neumorphic.main

    var body: some View {
        DemoSection("Shadows") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 115), spacing: 16)], spacing: 18) {
                DemoLabeledControl("Inner Shadow") { Circle().fill(main).frame(width: size, height: size).softInnerShadow(Circle()) }
                DemoLabeledControl("Outer Shadow") { Circle().fill(main).frame(width: size, height: size).softOuterShadow() }
                DemoLabeledControl("Inner + Outer") {
                    ZStack { Circle().fill(main).softInnerShadow(Circle(), spread: 0.6); Circle().fill(main).frame(width: 80, height: 80).softOuterShadow(offset: 8, radius: 8) }.frame(width: size, height: size)
                }
                DemoLabeledControl("Outer + Inner") {
                    ZStack { Circle().fill(main).softOuterShadow(); Circle().fill(main).frame(width: 80, height: 80).softInnerShadow(Circle(), radius: 5) }.frame(width: size, height: size)
                }
            }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 115), spacing: 16)], spacing: 18) {
                DemoLabeledControl("Rounded Outer") { RoundedRectangle(cornerRadius: 20).fill(main).frame(width: size, height: size).softOuterShadow() }
                DemoLabeledControl("Rounded Inner") { RoundedRectangle(cornerRadius: 20).fill(main).frame(width: size, height: size).softInnerShadow(RoundedRectangle(cornerRadius: 20)) }
                DemoLabeledControl("Rectangle Outer") { Rectangle().fill(main).frame(width: size, height: size).softOuterShadow() }
            }
        }
    }
}

struct ExampleShowcaseView_Previews: PreviewProvider {
    static var previews: some View {
        Group { ExampleShowcaseView().environment(\.colorScheme, .light); ExampleShowcaseView().environment(\.colorScheme, .dark) }
    }
}
