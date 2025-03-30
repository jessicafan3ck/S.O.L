import SwiftUI

struct ThreadsPollsView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Ad Banner
                HStack(spacing: 0) {
                    // Sportsbook & Casino (Green Box)
                    VStack {
                        Text("SPORTSBOOK")
                            .font(.system(size: 10))
                        Text("$")
                            .font(.system(size: 20, weight: .bold))
                        Text("& CASINO")
                            .font(.system(size: 10))
                    }
                    .frame(width: 64, height: 64)
                    .background(Color.green)
                    .foregroundColor(.white)
                    
                    // Middle Text
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Level up your...")
                            .font(.system(size: 18, weight: .bold))
                        Text("draftkings.com")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Text("Ad")
                            .font(.system(size: 10))
                            .padding(.horizontal, 4)
                            .padding(.vertical, 1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    .padding(.leading, 8)
                    
                    // Image
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 64)
                    
                    // Bet Now (Blue Box)
                    VStack {
                        Text("BET")
                            .font(.system(size: 14, weight: .bold))
                        Text("NOW")
                            .font(.system(size: 14, weight: .bold))
                    }
                    .frame(width: 64, height: 64)
                    .background(Color.blue)
                    .foregroundColor(.white)
                }
                .padding(.vertical, 8)
                .background(Color.white)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(.systemGray5)),
                    alignment: .bottom
                )
                
                // Header
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24))
                    }
                    
                    Text("OnlyPolls")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: {}) {
                            Text("Hot")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {}) {
                            Text("New")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {}) {
                            Text("Top")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 24))
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(.systemGray5)),
                    alignment: .bottom
                )
                
                // Sub Header
                HStack {
                    Text("Polls only")
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Share Invite")
                            .font(.system(size: 16, weight: .medium))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray5))
                            .cornerRadius(20)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(.systemGray5)),
                    alignment: .bottom
                )
                
                ScrollView {
                    VStack(spacing: 0) {
                        // First Poll
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                // Profile circle
                                ZStack {
                                    Circle()
                                        .fill(Color.blue.opacity(0.2))
                                        .frame(width: 40, height: 40)
                                    
                                    Text("OP")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.blue)
                                }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    // User info and options
                                    HStack {
                                        Text("OnlyPolls")
                                            .font(.system(size: 16, weight: .bold))
                                        Text("4h")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 8)
                                        
                                        Spacer()
                                        
                                        Button(action: {}) {
                                            Image(systemName: "ellipsis")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                    // Post content
                                    Text("No context")
                                        .padding(.vertical, 8)
                                    
                                    Text("#poll")
                                        .foregroundColor(.gray)
                                        .padding(.bottom, 12)
                                    
                                    // Poll options
                                    VStack(spacing: 8) {
                                        Button(action: {}) {
                                            Text("Bees")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(16)
                                                .background(Color(.systemGray6))
                                                .cornerRadius(8)
                                        }
                                        
                                        Button(action: {}) {
                                            Text("Wasps")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(16)
                                                .background(Color(.systemGray6))
                                                .cornerRadius(8)
                                        }
                                        
                                        Button(action: {}) {
                                            Text("Hornets")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(16)
                                                .background(Color(.systemGray6))
                                                .cornerRadius(8)
                                        }
                                    }
                                    .padding(.bottom, 12)
                                    
                                    // Results info
                                    HStack {
                                        Button(action: {}) {
                                            Text("View Results")
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        Text("131 votes")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.bottom, 12)
                                    
                                    // Action buttons
                                    HStack {
                                        Button(action: {}) {
                                            Image(systemName: "message")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.trailing, 16)
                                        
                                        Button(action: {}) {
                                            Image(systemName: "paperplane")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.trailing, 16)
                                        
                                        Button(action: {}) {
                                            Image(systemName: "arrow.2.squarepath")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.trailing, 16)
                                        
                                        Button(action: {}) {
                                            Image(systemName: "square.and.arrow.up")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.trailing, 16)
                                        
                                        Spacer()
                                        
                                        // Vote buttons
                                        HStack(spacing: 8) {
                                            Button(action: {}) {
                                                Image(systemName: "arrow.up")
                                                    .frame(width: 40, height: 32)
                                                    .background(Color(.systemGray5))
                                                    .cornerRadius(4)
                                            }
                                            
                                            Text("8")
                                                .foregroundColor(.green)
                                                .fontWeight(.bold)
                                            
                                            Button(action: {}) {
                                                Image(systemName: "arrow.down")
                                                    .frame(width: 40, height: 32)
                                                    .background(Color(.systemGray5))
                                                    .cornerRadius(4)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(16)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.systemGray5)),
                            alignment: .bottom
                        )
                        
                        // Second Poll
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                // Profile image
                                Image("placeholder")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    // User info and options
                                    HStack {
                                        Text("OnlyPolls")
                                            .font(.system(size: 16, weight: .bold))
                                        Text("3h")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 8)
                                        
                                        Spacer()
                                        
                                        Button(action: {}) {
                                            Text("Follow")
                                                .font(.system(size: 14, weight: .medium))
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 4)
                                                .background(Color(.systemGray5))
                                                .cornerRadius(20)
                                        }
                                        
                                        Button(action: {}) {
                                            Image(systemName: "ellipsis")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                    // Yellow pill
                                    Text("yellowpill")
                                        .foregroundColor(.gray)
                                    
                                    // Post content
                                    Text("If you could see one planet and come back alive")
                                        .padding(.vertical, 8)
                                    
                                    Text("#poll")
                                        .foregroundColor(.gray)
                                        .padding(.bottom, 12)
                                    
                                    // Poll options
                                    VStack(spacing: 8) {
                                        Button(action: {}) {
                                            Text("Mercury")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(16)
                                                .background(Color(.systemGray6))
                                                .cornerRadius(8)
                                        }
                                        
                                        Button(action: {}) {
                                            Text("Venus")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(16)
                                                .background(Color(.systemGray6))
                                                .cornerRadius(8)
                                        }
                                        
                                        Button(action: {}) {
                                            Text("Mars")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(16)
                                                .background(Color(.systemGray6))
                                                .cornerRadius(8)
                                        }
                                    }
                                    .padding(.bottom, 12)
                                    
                                    // Results info
                                    HStack {
                                        Button(action: {}) {
                                            Text("View Results")
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        Text("votes")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.bottom, 12)
                                    
                                    // Action buttons
                                    HStack {
                                        Button(action: {}) {
                                            HStack {
                                                Image(systemName: "message")
                                                    .foregroundColor(.gray)
                                                Text("2")
                                                    .foregroundColor(.gray)
                                                    .padding(.leading, 4)
                                            }
                                        }
                                        .padding(.trailing, 16)
                                        
                                        Button(action: {}) {
                                            Image(systemName: "paperplane")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.trailing, 16)
                                        
                                        Button(action: {}) {
                                            Image(systemName: "arrow.2.squarepath")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.trailing, 16)
                                        
                                        Button(action: {}) {
                                            Image(systemName: "square.and.arrow.up")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.trailing, 16)
                                        
                                        Spacer()
                                        
                                        // Vote buttons
                                        HStack(spacing: 8) {
                                            Button(action: {}) {
                                                Image(systemName: "arrow.up")
                                                    .frame(width: 40, height: 32)
                                                    .background(Color(.systemGray5))
                                                    .cornerRadius(4)
                                            }
                                            
                                            Button(action: {}) {
                                                Image(systemName: "arrow.down")
                                                    .frame(width: 40, height: 32)
                                                    .background(Color(.systemGray5))
                                                    .cornerRadius(4)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(16)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.systemGray5)),
                            alignment: .bottom
                        )
                    }
                }
                
                Spacer(minLength: 80) // Space for bottom nav bar
            }
            
            // New Post Button
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color.blue.opacity(0.8))
                            .cornerRadius(28)
                            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
                    }
                    .padding(.trailing, 16)
                    .padding(.bottom, 96)
                }
            }
            
            // Bottom Navigation
            VStack {
                Spacer()
                
                HStack {
                    Button(action: {}) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "person")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.vertical, 12)
                .background(Color.white)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(.systemGray5)),
                    alignment: .top
                )
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
