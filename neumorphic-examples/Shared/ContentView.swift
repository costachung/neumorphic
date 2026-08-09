import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ExampleShowcaseView()
                .tabItem {
                    ExampleTabLabel("Examples", systemImage: "square.grid.2x2")
                }
            ExampleSettingsView()
                .tabItem {
                    ExampleTabLabel("Settings", systemImage: "gearshape")
                }
        }
    }
}

private struct ExampleTabLabel: View {
    let title: String
    let systemImage: String

    init(_ title: String, systemImage: String) {
        self.title = title
        self.systemImage = systemImage
    }

    var body: some View {
        Label(title, systemImage: systemImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.colorScheme, .light)
            ContentView().environment(\.colorScheme, .dark)
        }
    }
}
