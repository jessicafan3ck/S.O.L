import SwiftUI

struct TikTokVideoView: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            // Content layers
            VStack(spacing: 0) {
                // Top Navigation
                HStack(spacing: 0) {
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Explore")
                            .font(.system(size: 18))
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.horizontal, 16)
                    }
                    
                    Button(action: {}) {
                        Text("Following")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .overlay(
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(.white),
                                alignment: .bottom
                            )
                    }
                    
                    Button(action: {}) {
                        Text("For You")
                            .font(.system(size: 18))
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.horizontal, 16)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 40)
                .padding(.horizontal, 16)
                
                // LIVE indicator
                HStack {
                    Text("LIVE")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.white, lineWidth: 1)
                        )
                    
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.top, 8)
                
                Spacer()
                
                // Bottom info
                VStack(alignment: .leading, spacing: 4) {
                    Text("ErinTrip")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("#softboiledeggs #softboiledegg #eggs #egg #KitchenHacks #kitchengadget... more")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 80)
                .padding(.trailing, 64)
                
                Spacer(minLength: 84) // Space for bottom navigation
            }
            
            // Right side interactions
            VStack {
                Spacer()
                
                VStack(spacing: 24) {
                    // Profile with plus button
                    ZStack(alignment: .bottom) {
                        Circle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 40, height: 40)
                        
                        ZStack {
                            Circle()
                                .fill(Color.pink)
                                .frame(width: 24, height: 24)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        .offset(y: 12)
                    }
                    
                    // Like Button
                    VStack(spacing: 4) {
                        Button(action: {}) {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                        }
                        
                        Text("157.5K")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                    // Comment Button
                    VStack(spacing: 4) {
                        Button(action: {}) {
                            Image(systemName: "message.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                        }
                        
                        Text("1,806")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                    // Bookmark Button
                    VStack(spacing: 4) {
                        Button(action: {}) {
                            Image(systemName: "bookmark")
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                        }
                        
                        Text("3,578")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                    // Share Button
                    VStack(spacing: 4) {
                        Button(action: {}) {
                            Image(systemName: "arrowshape.turn.up.right")
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                        }
                        
                        Text("3,732")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.trailing, 16)
                .padding(.bottom, 112)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            // Bottom Navigation
            VStack {
                Spacer()
                
                HStack(spacing: 0) {
                    // Home Button
                    VStack(spacing: 4) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        
                        Text("Home")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Friends Button
                    VStack(spacing: 4) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24))
                            .foregroundColor(.white.opacity(0.7))
                        
                        Text("Friends")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Plus Button
                    VStack(spacing: 4) {
                        ZStack {
                            Rectangle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [.cyan, .pink]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                                .frame(width: 48, height: 32)
                                .cornerRadius(8)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                        
                        Text(" ")
                            .font(.system(size: 12))
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Inbox Button
                    VStack(spacing: 4) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "message")
                                .font(.system(size: 24))
                                .foregroundColor(.white.opacity(0.7))
                            
                            ZStack {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 16, height: 16)
                                
                                Text("7")
                                    .font(.system(size: 10))
                                    .foregroundColor(.white)
                            }
                            .offset(x: 4, y: -4)
                        }
                        
                        Text("Inbox")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Profile Button
                    VStack(spacing: 4) {
                        Image(systemName: "person")
                            .font(.system(size: 24))
                            .foregroundColor(.white.opacity(0.7))
                        
                        Text("Profile")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.top, 8)
                .padding(.bottom, 32)
                .background(Color.black)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
    }
}
