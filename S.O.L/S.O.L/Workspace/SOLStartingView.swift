import SwiftUI

struct SOLStartingView: View {
    @State private var navigateToDisguiseSelection = false
    @State private var showingOnboarding = false
    @State private var animateLogo = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 255/255, green: 125/255, blue: 69/255),
                        Color(red: 255/255, green: 80/255, blue: 10/255)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                // Content
                VStack(spacing: 0) {
                    Spacer()
                    
                    // Logo and branding
                    LogoView(animate: $animateLogo)
                        .padding(.bottom, 40)
                    
                    Text("Safety On Line")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.bottom, 24)
                    
                    Text("Your discreet emergency companion")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 60)
                    
                    Spacer()
                    
                    // Action buttons
                    VStack(spacing: 16) {
                        NavigationLink(destination: DisguiseSelectionView()) {
                            Text("Get Started")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color(red: 255/255, green: 125/255, blue: 69/255))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(16)
                        }
                        
                        Button(action: {
                            showingOnboarding = true
                        }) {
                            Text("Learn More")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 40)
                }
            }
            .onAppear {
                // Start animation when view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                        animateLogo = true
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToDisguiseSelection) {
                DisguiseSelectionView()
            }
            .sheet(isPresented: $showingOnboarding) {
                OnboardingView()
            }
        }
    }
}

struct LogoView: View {
    @Binding var animate: Bool
    
    var body: some View {
        ZStack {
            // Outer shield shape
            Circle()
                .fill(Color.white.opacity(0.2))
                .frame(width: 160, height: 160)
                .scaleEffect(animate ? 1.0 : 0.8)
            
            // Inner shield
            Circle()
                .fill(Color.white)
                .frame(width: 120, height: 120)
                .scaleEffect(animate ? 1.0 : 0.6)
            
            // S.O.L letters
            Text("S.O.L")
                .font(.system(size: 44, weight: .bold))
                .foregroundColor(Color(red: 255/255, green: 80/255, blue: 10/255))
                .offset(y: animate ? 0 : 20)
                .opacity(animate ? 1.0 : 0.0)
        }
    }
}

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    HStack {
                        Text("How S.O.L Works")
                            .font(.system(size: 28, weight: .bold))
                        
                        Spacer()
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.bottom, 8)
                    
                    // Feature sections
                    FeatureSection(
                        icon: "eye.slash",
                        title: "Disguised Interface",
                        description: "S.O.L hides its emergency features inside interfaces that look like everyday apps."
                    )
                    
                    FeatureSection(
                        icon: "hand.tap",
                        title: "Secret Triggers",
                        description: "Configure custom gestures that activate emergency mode without anyone noticing."
                    )
                    
                    FeatureSection(
                        icon: "person.crop.circle.badge.exclamationmark",
                        title: "Emergency Contacts",
                        description: "S.O.L can immediately alert trusted contacts or emergency services when activated."
                    )
                    
                    FeatureSection(
                        icon: "location",
                        title: "Location Sharing",
                        description: "Automatically share your location with your emergency contacts."
                    )
                    
                    // Privacy notice
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Privacy & Security")
                            .font(.system(size: 20, weight: .bold))
                        
                        Text("Your safety is our priority. All data is encrypted and stored locally on your device.")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    
                    // Continue button
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Got It")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 255/255, green: 125/255, blue: 69/255))
                            .cornerRadius(16)
                    }
                    .padding(.top, 24)
                }
                .padding(24)
            }
        }
    }
}

struct FeatureSection: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 36))
                .foregroundColor(Color(red: 255/255, green: 125/255, blue: 69/255))
                .frame(width: 44)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                
                Text(description)
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
            }
        }
    }
}

