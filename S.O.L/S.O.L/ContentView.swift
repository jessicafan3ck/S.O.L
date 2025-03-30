import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SettingsTabView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}
