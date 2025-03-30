import SwiftUI

struct InstagramFeedView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Instagram")
                    .font(.title)
                    .fontWeight(.bold)
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Image(systemName: "heart")
                            .font(.system(size: 24))
                    }
                    
                    Button(action: {}) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 24))
                            
                            ZStack {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 20, height: 20)
                                
                                Text("4")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                            }
                            .offset(x: 8, y: -8)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            
            // Stories
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    // Your Story
                    VStack(alignment: .center) {
                        ZStack(alignment: .bottomTrailing) {
                            Image("placeholder")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                            
                            ZStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 24, height: 24)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                
                                Text("+")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Text("Your story")
                            .font(.system(size: 12))
                            .padding(.top, 4)
                    }
                    
                    // Emily's Story
                    VStack(alignment: .center) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.yellow, .orange, .pink]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 68, height: 68)
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 64, height: 64)
                                .overlay(
                                    Image("placeholder")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                )
                        }
                        
                        Text("emilythen05")
                            .font(.system(size: 12))
                            .padding(.top, 4)
                    }
                    
                    // Kaitlynn's Story
                    VStack(alignment: .center) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.yellow, .orange, .pink]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 68, height: 68)
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 64, height: 64)
                                .overlay(
                                    Image("placeholder")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                )
                        }
                        
                        Text("k.aitlynnn18")
                            .font(.system(size: 12))
                            .padding(.top, 4)
                    }
                    
                    // Natalie's Story
                    VStack(alignment: .center) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.yellow, .orange, .pink]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 68, height: 68)
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 64, height: 64)
                                .overlay(
                                    Image("placeholder")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                )
                        }
                        
                        Text("natalieknguyn")
                            .font(.system(size: 12))
                            .padding(.top, 4)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
            }
            .overlay(
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(Color(.systemGray3)),
                alignment: .bottom
            )
            
            // Post
            ScrollView {
                VStack(spacing: 0) {
                    // Post Header
                    HStack {
                        HStack {
                            Image("placeholder")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                            
                            Text("audriana.varner")
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "ellipsis")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    
                    // Post Image
                    ZStack(alignment: .bottomTrailing) {
                        Image("placeholder")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("2/3")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(20)
                                .padding(12)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(maxHeight: .infinity, alignment: .top)
                        
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.7))
                                .frame(width: 32, height: 32)
                            
                            Image(systemName: "speaker.wave.2.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                        }
                        .padding(12)
                    }
                    
                    // Post Actions
                    HStack {
                        HStack(spacing: 16) {
                            Button(action: {}) {
                                Image(systemName: "heart")
                                    .font(.system(size: 24))
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "message")
                                    .font(.system(size: 24))
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "paperplane")
                                    .font(.system(size: 24))
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "bookmark")
                                .font(.system(size: 24))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    
                    // Post Metadata
                    VStack(alignment: .leading, spacing: 4) {
                        Text("246 likes")
                            .fontWeight(.bold)
                        
                        HStack(spacing: 4) {
                            Text("Liked by")
                                .foregroundColor(.gray)
                            
                            Text("josephwan06")
                                .fontWeight(.bold)
                            
                            Text("and")
                                .foregroundColor(.gray)
                            
                            Text("others")
                                .fontWeight(.bold)
                        }
                        .font(.system(size: 14))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 12)
                }
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(.systemGray3)),
                    alignment: .bottom
                )
            }
            
            // Bottom Navigation
            HStack(spacing: 0) {
                Button(action: {}) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity)
                }
                
                NavigationLink(destination: InstagramSearchView()) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24))
                            .frame(maxWidth: .infinity)
                    }
                
                Button(action: {}) {
                    Image(systemName: "plus.app")
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity)
                }
                
                Button(action: {}) {
                    Image(systemName: "play.rectangle")
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity)
                }
                
                Button(action: {}) {
                    ZStack(alignment: .bottomTrailing) {
                        Image("placeholder")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .clipShape(Circle())
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 8, height: 8)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 12)
            .overlay(
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(Color(.systemGray3)),
                alignment: .top
            )
        }
    }
}

