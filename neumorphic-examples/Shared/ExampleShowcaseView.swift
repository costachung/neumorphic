// 
//  ContentView.swift
//  neumorphic-examples
//

import Neumorphic
import SwiftUI

struct ExampleShowcaseView: View {
    var body: some View {
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    Text("Neumorphic Examples")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.Neumorphic.secondary)
                        .exampleHeaderTrait()
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
    @State private var password = ""
    @State private var mode = "Light"

    var body: some View {
        DemoSection("Common Controls") {
            AdaptiveStack {
                DemoLabeledControl("Slider") {
                    NeumorphicSlider(value: $sliderValue, in: 0...100, step: 1, tint: .accentColor)
                        .frame(maxWidth: 360)
                }
                DemoLabeledControl("TextField") {
                    NeumorphicTextField("Name", text: $name)
                        .frame(maxWidth: 360)
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Secure TextField") {
                    NeumorphicTextField("Password", text: $password, secure: true)
                        .frame(maxWidth: 360)
                }
                DemoLabeledControl("Picker") {
                    NeumorphicPicker(selection: $mode, options: ["Light", "Dark"])
                        .frame(maxWidth: 360)
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Linear 65%") {
                    NeumorphicProgressView(value: 0.65, tint: .green)
                        .frame(maxWidth: 360)
                }
                DemoLabeledControl("Linear Loading") {
                    NeumorphicProgressView(value: nil, tint: .blue)
                        .frame(maxWidth: 360)
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Circular 65%") {
                    NeumorphicCircularProgressView(value: 0.65, tint: .green)
                }
                DemoLabeledControl("Circular Loading") {
                    NeumorphicCircularProgressView(value: nil, tint: .blue)
                }
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
            DemoLabeledControl("DatePicker") {
                NeumorphicDatePicker("Start", selection: $date, displayedComponents: .date)
            }
            DemoLabeledControl("Menu") {
                NeumorphicMenu("Mode", selection: $mode, options: ["Light", "Dark"])
            }
            NeumorphicDisclosureGroup("Details", isExpanded: $expanded) {
                Text("Expandable content")
                    .foregroundColor(Color.Neumorphic.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            DemoLabeledControl("Link") {
                NeumorphicLink("Website", destination: URL(string: "https://example.com")!)
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
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
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
                .exampleHeaderTrait()
            content
        }
    }
}

struct AdaptiveStack<Content: View>: View {
    @Environment(\.sizeCategory) private var sizeCategory
    @State private var availableWidth: CGFloat = 0

    private let spacing: CGFloat
    private let minimumHorizontalWidth: CGFloat
    private let content: Content

    init(
        spacing: CGFloat = 16,
        minimumHorizontalWidth: CGFloat = 320,
        @ViewBuilder content: () -> Content
    ) {
        self.spacing = spacing
        self.minimumHorizontalWidth = minimumHorizontalWidth
        self.content = content()
    }

    private var usesVerticalLayout: Bool {
        availableWidth < minimumHorizontalWidth || isAccessibilitySize
    }

    private var isAccessibilitySize: Bool {
        switch sizeCategory {
        case .accessibilityMedium,
            .accessibilityLarge,
            .accessibilityExtraLarge,
            .accessibilityExtraExtraLarge,
            .accessibilityExtraExtraExtraLarge:
            return true
        default:
            return false
        }
    }

    var body: some View {
        Group {
            if usesVerticalLayout {
                VStack(spacing: spacing) { content }
            } else {
                HStack(alignment: .top, spacing: spacing) { content }
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            GeometryReader { proxy in
                Color.clear.preference(key: AvailableWidthPreferenceKey.self, value: proxy.size.width)
            }
        )
        .onPreferenceChange(AvailableWidthPreferenceKey.self) { availableWidth = $0 }
    }
}

private struct AvailableWidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

private struct DemoButtonsView: View {
    var body: some View {
        DemoSection("Buttons") {
            AdaptiveStack {
                DemoLabeledControl("Capsule") {
                    Button("Button", action: {})
                        .buttonStyle(exampleButtonStyle(Capsule()))
                }
                DemoLabeledControl("Rounded Rectangle") {
                    Button("Button", action: {})
                        .buttonStyle(exampleButtonStyle(RoundedRectangle(cornerRadius: 20)))
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Ellipse") {
                    Button("Button", action: {})
                        .buttonStyle(exampleButtonStyle(Ellipse()))
                }
                DemoLabeledControl("Circle") {
                    Button(action: {}) { ExampleSymbol(systemName: "heart.fill") }
                        .buttonStyle(exampleButtonStyle(Circle()))
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Custom Color") {
                    Button(action: {}) { ExampleSymbol(systemName: "heart.fill") }
                        .buttonStyle(exampleButtonStyle(Circle(), mainColor: .red, textColor: .white))
                }
                DemoLabeledControl("Custom Size") {
                    Button("Button", action: {})
                        .buttonStyle(exampleButtonStyle(Capsule(), padding: 15))
                        .frame(width: 150)
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Padding") {
                    Button("Button", action: {})
                        .buttonStyle(exampleButtonStyle(RoundedRectangle(cornerRadius: 20), padding: 10))
                }
                DemoLabeledControl("Disabled") {
                    Button("Button", action: {})
                        .buttonStyle(exampleButtonStyle(RoundedRectangle(cornerRadius: 20), padding: 10))
                        .disabled(true)
                }
            }
            Text("Pressed Effect").font(.subheadline).foregroundColor(Color.Neumorphic.secondary)
                .exampleHeaderTrait()
            AdaptiveStack {
                DemoLabeledControl("None") {
                    Button("Button", action: {})
                        .buttonStyle(exampleButtonStyle(Capsule(), pressedEffect: .none))
                }
                DemoLabeledControl("Flat") {
                    Button("Button", action: {})
                        .buttonStyle(exampleButtonStyle(Capsule(), pressedEffect: .flat))
                }
            }
            DemoLabeledControl("Hard") {
                Button("Button", action: {})
                    .buttonStyle(exampleButtonStyle(Capsule(), pressedEffect: .hard))
            }
            ContextMenuDemo()
        }
    }
}

private struct ContextMenuDemo: View {
    @State private var result = "No action selected"

    var body: some View {
        DemoLabeledControl("Context Menu") {
            VStack(spacing: 8) {
                Button("Open Menu") { result = "Primary button selected" }
                    .buttonStyle(exampleButtonStyle(Capsule(), pressedEffect: .none))
                    .contextMenu {
                        Button("Favorite") { result = "Favorite selected" }
                        Button("Archive") { result = "Archive selected" }
                    }
                Text(result)
                    .font(.caption)
                    .foregroundColor(Color.Neumorphic.secondary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

private struct DemoTogglesView: View {
    @State private var isOn = false

    var body: some View {
        DemoSection("Toggles") {
            AdaptiveStack {
                DemoLabeledControl("System Default") {
                    Toggle("Toggle", isOn: $isOn)
                        .toggleStyle(SwitchToggleStyle())
                }
                DemoLabeledControl("Rectangle") {
                    Toggle("Rect", isOn: $isOn)
                        .toggleStyle(exampleToggleStyle(Rectangle()))
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Rectangle Flat") {
                    Toggle("Rect", isOn: $isOn)
                        .toggleStyle(exampleToggleStyle(Rectangle(), pressedEffect: .flat))
                }
                DemoLabeledControl("Rounded Rectangle") {
                    Toggle("Rounded", isOn: $isOn)
                        .toggleStyle(exampleToggleStyle(RoundedRectangle(cornerRadius: 8)))
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Rounded Flat") {
                    Toggle("Rounded", isOn: $isOn)
                        .toggleStyle(exampleToggleStyle(RoundedRectangle(cornerRadius: 8), pressedEffect: .flat))
                }
                DemoLabeledControl("Capsule") {
                    Toggle("Capsule", isOn: $isOn)
                        .toggleStyle(exampleToggleStyle(Capsule()))
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Capsule Flat") {
                    Toggle("Capsule", isOn: $isOn)
                        .toggleStyle(exampleToggleStyle(Capsule(), pressedEffect: .flat))
                }
                DemoLabeledControl("Circle") {
                    Toggle(isOn: $isOn) {
                        ExampleSymbol(systemName: isOn ? "stop.fill" : "play.fill")
                    }
                    .toggleStyle(exampleToggleStyle(Circle(), padding: 20))
                }
            }
            DemoLabeledControl("Circle Flat") {
                Toggle(isOn: $isOn) {
                    ExampleSymbol(systemName: isOn ? "stop.fill" : "play.fill")
                }
                .toggleStyle(exampleToggleStyle(Circle(), padding: 20, pressedEffect: .flat))
            }
        }
    }
}

private struct DemoSwitchesView: View {
    @State private var isOn = false

    var body: some View {
        DemoSection("Switches") {
            AdaptiveStack {
                DemoLabeledControl("System Enabled") {
                    Toggle("Toggle", isOn: $isOn).toggleStyle(SwitchToggleStyle()).labelsHidden()
                }
                DemoLabeledControl("System Disabled") {
                    Toggle("Toggle", isOn: $isOn)
                        .toggleStyle(SwitchToggleStyle())
                        .labelsHidden()
                        .disabled(true)
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Neumorphic Green") {
                    Toggle("Toggle", isOn: $isOn)
                        .toggleStyle(NeumorphicSwitchToggleStyle(tint: .green, labelsHidden: true))
                }
                DemoLabeledControl("Neumorphic Blue") {
                    Toggle("Toggle", isOn: $isOn)
                        .toggleStyle(NeumorphicSwitchToggleStyle(tint: .blue, labelsHidden: true))
                }
            }
            DemoLabeledControl("Neumorphic Disabled") {
                Toggle("Toggle", isOn: $isOn)
                    .toggleStyle(NeumorphicSwitchToggleStyle(tint: .red, labelsHidden: true))
                    .disabled(true)
            }
        }
    }
}

private struct DemoShadowsView: View {
    private let size: CGFloat = 120
    private let main = Color.Neumorphic.main

    var body: some View {
        DemoSection("Shadows") {
            AdaptiveStack {
                DemoLabeledControl("Inner Shadow") {
                    Circle().fill(main).frame(width: size, height: size).softInnerShadow(Circle())
                }
                DemoLabeledControl("Outer Shadow") {
                    Circle().fill(main).frame(width: size, height: size).softOuterShadow()
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Inner + Outer") {
                    ZStack {
                        Circle().fill(main).softInnerShadow(Circle(), spread: 0.6)
                        Circle().fill(main).frame(width: 80, height: 80).softOuterShadow(offset: 8, radius: 8)
                    }.frame(width: size, height: size)
                }
                DemoLabeledControl("Outer + Inner") {
                    ZStack {
                        Circle().fill(main).softOuterShadow()
                        Circle().fill(main).frame(width: 80, height: 80).softInnerShadow(Circle(), radius: 5)
                    }.frame(width: size, height: size)
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Rounded Outer") {
                    RoundedRectangle(cornerRadius: 20).fill(main).frame(width: size, height: size).softOuterShadow()
                }
                DemoLabeledControl("Rounded Inner") {
                    RoundedRectangle(cornerRadius: 20).fill(main).frame(width: size, height: size).softInnerShadow(
                        RoundedRectangle(cornerRadius: 20))
                }
            }
            AdaptiveStack {
                DemoLabeledControl("Rectangle Outer") {
                    Rectangle().fill(main).frame(width: size, height: size).softOuterShadow()
                }
                DemoLabeledControl("Inner Preset") {
                    Circle().fill(main).frame(width: size, height: size).softInnerShadow(Circle(), preset: .subtle)
                }
            }
        }
    }
}

private func exampleButtonStyle<S: Shape>(
    _ shape: S,
    padding: CGFloat = 16,
    mainColor: Color = Color.Neumorphic.main,
    textColor: Color = Color.Neumorphic.secondary,
    darkShadowColor: Color = Color.Neumorphic.darkShadow,
    lightShadowColor: Color = Color.Neumorphic.lightShadow,
    pressedEffect: SoftButtonPressedEffect = .hard
) -> SoftDynamicButtonStyle<S> {
    SoftDynamicButtonStyle(
        shape,
        mainColor: mainColor,
        textColor: textColor,
        darkShadowColor: darkShadowColor,
        lightShadowColor: lightShadowColor,
        pressedEffect: pressedEffect,
        padding: padding
    )
}

private func exampleToggleStyle<S: Shape>(
    _ shape: S,
    padding: CGFloat = 16,
    mainColor: Color = Color.Neumorphic.main,
    textColor: Color = Color.Neumorphic.secondary,
    darkShadowColor: Color = Color.Neumorphic.darkShadow,
    lightShadowColor: Color = Color.Neumorphic.lightShadow,
    pressedEffect: SoftButtonPressedEffect = .hard
) -> SoftDynamicToggleStyle<S> {
    SoftDynamicToggleStyle(
        shape,
        mainColor: mainColor,
        textColor: textColor,
        darkShadowColor: darkShadowColor,
        lightShadowColor: lightShadowColor,
        pressedEffect: pressedEffect,
        padding: padding
    )
}

struct ExampleSymbol: View {
    let systemName: String

    var body: some View {
        Image(systemName: systemName)
    }
}

extension View {
    func exampleHeaderTrait() -> some View {
        accessibilityAddTraits(.isHeader)
    }
}

struct ExampleShowcaseView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExampleShowcaseView()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Examples · Light")
            ExampleShowcaseView()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Examples · Dark")
            ExampleShowcaseView()
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewDisplayName("Examples · Largest Text")
        }
    }
}
