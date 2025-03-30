
import SwiftUI

@main
struct SolApp: App {
    @State private var showSettings = false
    @State private var selectedTab = 0
    
    var body: some Scene {
        WindowGroup {
            SpotifyHomeView()}
            }
        }
