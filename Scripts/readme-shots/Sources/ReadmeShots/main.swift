import AppKit
import Neumorphic
import SwiftUI

// Renders the README illustrations from the same code the README shows, so the
// images cannot drift from the snippets beside them. Run from the repository root:
//
//     swift run --package-path Scripts/readme-shots readme-shots
//
// `hero.png` and `search-bar.png` are not produced here: they contain a TextField,
// which ImageRenderer draws as an "unsupported" placeholder. See README.md in this
// directory for how those two and the animated GIF are captured instead.

let outputDirectory = URL(fileURLWithPath: CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "Docs/images")

/// Renders one illustration onto the neumorphic surface color and writes it as a PNG.
@MainActor
func write<Content: View>(_ name: String, padding: CGFloat = 32, @ViewBuilder _ content: () -> Content) {
    let framed = content()
        .padding(padding)
        .background(Color.Neumorphic.main)
        .environment(\.colorScheme, .light)
    let renderer = ImageRenderer(content: framed)
    renderer.scale = 3
    guard let image = renderer.cgImage,
        let data = NSBitmapImageRep(cgImage: image).representation(using: .png, properties: [:])
    else {
        print("failed \(name)")
        return
    }
    let url = outputDirectory.appendingPathComponent("\(name).png")
    do {
        try data.write(to: url)
        print("wrote \(url.path) \(image.width)x\(image.height)")
    } catch {
        print("failed \(name): \(error.localizedDescription)")
    }
}

/// The bar chart the README builds out of an inner-shadowed track and a plain fill.
private struct BarChart: View {
    private let bars: [(value: CGFloat, color: Color)] = [
        (60, .blue), (110, .green), (86, .orange), (140, .purple), (44, .pink),
    ]

    var body: some View {
        HStack(alignment: .bottom, spacing: 18) {
            ForEach(Array(bars.enumerated()), id: \.offset) { _, bar in
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.Neumorphic.main)
                        .softInnerShadow(RoundedRectangle(cornerRadius: 20), spread: 0.3, radius: 2)
                        .frame(width: 30, height: 150)

                    RoundedRectangle(cornerRadius: 20)
                        .fill(bar.color)
                        .frame(width: 30, height: bar.value)
                }
            }
        }
    }
}

/// The switch toggle style in both states.
private struct SwitchToggles: View {
    @State private var isOff = false
    @State private var isOn = true

    var body: some View {
        HStack(spacing: 40) {
            Toggle("Off", isOn: $isOff)
                .toggleStyle(.neumorphicSwitch)
                .fixedSize()
            Toggle("On", isOn: $isOn)
                .toggleStyle(.neumorphicSwitch)
                .fixedSize()
        }
        .foregroundColor(Color.Neumorphic.secondary)
    }
}

/// The shape toggle in both states, which presses in and stays in.
private struct ShapeToggles: View {
    @State private var isOff = false
    @State private var isOn = true

    var body: some View {
        HStack(spacing: 36) {
            Toggle(isOn: $isOff) {
                Image(systemName: isOff ? "stop.fill" : "play.fill").font(.title)
            }
            .neumorphicThemedToggleStyle(Circle(), padding: 20)
            Toggle(isOn: $isOn) {
                Image(systemName: isOn ? "stop.fill" : "play.fill").font(.title)
            }
            .neumorphicThemedToggleStyle(Circle(), padding: 20)
        }
    }
}

MainActor.assumeIsolated {
    write("outer-shadow") {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.Neumorphic.main)
            .frame(width: 260, height: 140)
            .softOuterShadow()
    }

    write("inner-shadow") {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.Neumorphic.main)
            .frame(width: 260, height: 140)
            .softInnerShadow(RoundedRectangle(cornerRadius: 20))
    }

    write("shadows-side-by-side") {
        HStack(spacing: 44) {
            Circle()
                .fill(Color.Neumorphic.main)
                .frame(width: 130, height: 130)
                .softOuterShadow()
            Circle()
                .fill(Color.Neumorphic.main)
                .frame(width: 130, height: 130)
                .softInnerShadow(Circle())
        }
    }

    write("bar-chart") { BarChart() }

    write("soft-button") {
        Button(action: {}) {
            Text("Soft Button").fontWeight(.bold)
        }
        .neumorphicThemedButtonStyle(RoundedRectangle(cornerRadius: 20))
    }

    write("custom-button") {
        HStack(spacing: 32) {
            Button(action: {}) {
                Image(systemName: "heart.fill")
            }
            .neumorphicThemedButtonStyle(Circle(), role: .accent)

            Button(action: {}) {
                Image(systemName: "heart.fill")
            }
            .buttonStyle(
                SoftDynamicButtonStyle(
                    Circle(),
                    mainColor: .red,
                    textColor: .white,
                    darkShadowColor: Color(red: 0.6, green: 0.2, blue: 0.2),
                    lightShadowColor: Color(red: 1.0, green: 0.5, blue: 0.5),
                    pressedEffect: .hard
                )
            )
        }
    }

    write("switch-toggle") { SwitchToggles() }

    write("shape-toggle") { ShapeToggles() }
}
