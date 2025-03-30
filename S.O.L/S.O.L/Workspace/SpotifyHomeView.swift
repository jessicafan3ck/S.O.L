import SwiftUI

// MARK: - SpotifyHomeView
struct SpotifyHomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.brown)
                                .frame(width: 32, height: 32)
                            
                            Text("J")
                                .foregroundColor(.white)
                        }
                        
                        HStack(spacing: 12) {
                            Button(action: {
                                // All action
                            }) {
                                Text("All")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .background(Color.green)
                                    .cornerRadius(20)
                            }
                            
                            Button(action: {
                                // Music action
                            }) {
                                Text("Music")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(20)
                            }
                            
                            Button(action: {
                                // Podcasts action
                            }) {
                                Text("Podcasts")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(20)
                            }
                            
                            Button(action: {
                                // Audiobooks action
                            }) {
                                Text("Audiobooks")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding()
                }
                
                // Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Top grid
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            // eternal sunshine 1
                            HStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 48, height: 48)
                                    .overlay(Image(systemName: "music.note"))
                                
                                VStack(alignment: .leading) {
                                    Text("eternal sunshine")
                                        .font(.caption)
                                    
                                    Text("deluxe: brighter day...")
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            // eternal sunshine 2
                            HStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 48, height: 48)
                                    .overlay(Image(systemName: "music.note"))
                                
                                VStack(alignment: .leading) {
                                    Text("eternal sunshine")
                                        .font(.caption)
                                    
                                    Text("deluxe: brighter...")
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    // More action
                                }) {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            // Playlist collage
                            HStack {
                                VStack {
                                    HStack(spacing: 2) {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 24, height: 24)
                                        
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 24, height: 24)
                                    }
                                    
                                    HStack(spacing: 2) {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 24, height: 24)
                                        
                                        ZStack {
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 24, height: 24)
                                            
                                            Text("⭐")
                                                .font(.caption2)
                                                .foregroundColor(.yellow)
                                        }
                                    }
                                }
                                .frame(width: 48, height: 48)
                                
                                Text("Playlist")
                                    .font(.caption)
                                    .lineLimit(1)
                                
                                Spacer()
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            // Daylist
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.blue.opacity(0.3))
                                        .frame(width: 48, height: 48)
                                    
                                    Circle()
                                        .fill(Color.yellow)
                                        .frame(width: 32, height: 32)
                                }
                                
                                Text("daylist")
                                    .font(.caption)
                                
                                Spacer()
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            // Dangerous Woman
                            HStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 48, height: 48)
                                    .overlay(Image(systemName: "music.note"))
                                
                                Text("Dangerous Woman")
                                    .font(.caption)
                                
                                Spacer()
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            // Pop 2008-2012
                            HStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 48, height: 48)
                                    .overlay(Image(systemName: "music.note"))
                                
                                Text("Pop 2008-2012 🔥 🔥 🔥")
                                    .font(.caption)
                                    .lineLimit(1)
                                
                                Spacer()
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            // On Repeat
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.blue)
                                        .frame(width: 48, height: 48)
                                    
                                    Text("∞")
                                        .font(.title2)
                                        .foregroundColor(.pink)
                                        .fontWeight(.bold)
                                }
                                
                                Text("On Repeat")
                                    .font(.caption)
                                
                                Spacer()
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            // MUSIC (Deluxe)
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.white)
                                        .frame(width: 48, height: 48)
                                    
                                    Text("I AM MUSIC")
                                        .font(.system(size: 8))
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                }
                                
                                Text("MUSIC (Deluxe)")
                                    .font(.caption)
                                
                                Spacer()
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        }
                        
                        // New release section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("New release from")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 36, height: 36)
                                    .overlay(Image(systemName: "person.fill")
                                        .foregroundColor(.white))
                                
                                Text("王秋实")
                                    .font(.title3)
                                    .fontWeight(.medium)
                            }
                            
                            HStack(spacing: 12) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 80, height: 80)
                                    .overlay(Image(systemName: "music.note"))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Single")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Text("你的名字 我的诗")
                                        .fontWeight(.medium)
                                    
                                    Text("王秋实")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    // More action
                                }) {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.gray)
                                }
                                
                                Button(action: {
                                    // Add action
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                }
                                
                                Button(action: {
                                    // Play action
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 40, height: 40)
                                        
                                        Image(systemName: "play.fill")
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        }
                        
                        // Uniquely yours section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Uniquely yours")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            HStack(spacing: 12) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color.blue.opacity(0.5))
                                        .frame(height: 96)
                                        .cornerRadius(8)
                                    
                                    Image(systemName: "waveform.path")
                                        .resizable()
                                        .frame(width: 80, height: 40)
                                        .foregroundColor(.green)
                                }
                                
                                ZStack {
                                    Rectangle()
                                        .fill(Color.blue.opacity(0.5))
                                        .frame(height: 96)
                                        .cornerRadius(8)
                                    
                                    Image(systemName: "infinity")
                                        .resizable()
                                        .frame(width: 80, height: 40)
                                        .foregroundColor(.pink)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Now Playing Bar
                VStack(spacing: 0) {
                    HStack {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                            .overlay(Image(systemName: "music.note"))
                        
                        VStack(alignment: .leading) {
                            Text("intro (end of the world) • Ariana Grande")
                                .font(.caption)
                            
                            Text("🎧 Beats Studio Pro")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Pause action
                        }) {
                            Image(systemName: "pause.fill")
                        }
                        
                        Button(action: {
                            // Play action
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 32, height: 32)
                                
                                Image(systemName: "play.fill")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 4)
                            
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: geometry.size.width / 4, height: 4)
                        }
                    }
                    .frame(height: 4)
                }
                .background(Color.gray.opacity(0.2))
                
                // Tab Bar
                HStack(spacing: 0) {
                    VStack {
                        Image(systemName: "house.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("Home")
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
                    
                    NavigationLink(destination: SpotifySearchView()) {
                        VStack {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            
                            Text("Search")
                                .font(.caption2)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    VStack {
                        Image(systemName: "chart.bar.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("Your Library")
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.top, 8)
                .padding(.bottom, 24)
                .background(Color.black)
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.bottom)
            }
            .background(Color.black)
            .foregroundColor(.white)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
