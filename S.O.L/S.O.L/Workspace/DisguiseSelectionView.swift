import SwiftUI

struct DisguiseSelectionView: View {
    @State private var selectedApp: AppDisguise?
    @State private var navigateToConfigView = false
    
    // Sample data for app disguises
    let appDisguises: [AppDisguise] = [
        AppDisguise(
            id: "spotify",
            name: "Spotify",
            color: Color(red: 30/255, green: 215/255, blue: 96/255),
            previewImage: "spotify_preview"
        ),
        AppDisguise(
            id: "reddit",
            name: "Reddit",
            color: Color(red: 255/255, green: 69/255, blue: 0/255),
            previewImage: "reddit_preview"
        ),
        AppDisguise(
            id: "tiktok",
            name: "TikTok",
            color: Color.black,
            previewImage: "tiktok_preview"
        ),
        AppDisguise(
            id: "instagram",
            name: "Instagram",
            color: Color(red: 225/255, green: 48/255, blue: 108/255),
            previewImage: "instagram_preview"
        ),
        AppDisguise(
            id: "twitter",
            name: "Twitter",
            color: Color(red: 29/255, green: 161/255, blue: 242/255),
            previewImage: "twitter_preview"
        ),
        AppDisguise(
            id: "threads",
            name: "Threads",
            color: Color.black,
            previewImage: "threads_preview"
        )
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                Text("Choose Your Disguise")
                    .font(.system(size: 28, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("Select which app UI you want SOL to mimic")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                // Grid of app disguises
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(appDisguises) { app in
                        DisguiseCard(
                            app: app,
                            isSelected: selectedApp?.id == app.id,
                            onTap: {
                                selectedApp = app
                            }
                        )
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Information text
                Text("Your S.O.L disguise will look like this app, but have S.O.L's hidden safety features.")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                // Continue button
                NavigationLink(destination: EmergencyInputView(appDisguise: selectedApp)) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedApp != nil ? Color(red: 255/255, green: 125/255, blue: 69/255) : Color.gray)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .disabled(selectedApp == nil)
                .padding(.bottom, 16)
            }
            .navigationBarTitle("", displayMode: .inline)
            .background(Color(UIColor.systemBackground))
            .navigationDestination(isPresented: $navigateToConfigView) {
                if let selectedApp = selectedApp {
                    TriggerConfigurationView(appDisguise: selectedApp)
                }
            }
        }
    }
}

struct DisguiseCard: View {
    let app: AppDisguise
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                ZStack(alignment: .bottomTrailing) {
                    Image(app.previewImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 140)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isSelected ? app.color : Color.clear, lineWidth: 3)
                        )
                }
                
                Text(app.name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isSelected ? app.color : .primary)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct AppDisguise: Identifiable {
    let id: String
    let name: String
    let color: Color
    let previewImage: String
}

struct TriggerConfigurationView: View {
    let appDisguise: AppDisguise
    
    var body: some View {
        VStack {
            Text("Configure Trigger for \(appDisguise.name)")
                .font(.title)
            
            Text("This is where users would configure their emergency trigger")
                .padding()
        }
    }
}

struct DisguiseSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DisguiseSelectionView()
    }
}
