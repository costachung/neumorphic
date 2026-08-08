import SwiftUI

@ViewBuilder
func demoNavigation<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    if #available(iOS 16.0, *) {
        NavigationStack {
            content()
        }
    } else {
        NavigationView {
            content()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
