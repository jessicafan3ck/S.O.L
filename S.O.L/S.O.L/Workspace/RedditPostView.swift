import SwiftUI

struct RedditPostView: View {
    @State private var showPostCreation = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    HStack {
                        Image(systemName: "line.horizontal.3")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                        
                        Text("reddit")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.orange)
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                        
                        ZStack(alignment: .topTrailing) {
                            Image("placeholder")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .clipShape(Circle())
                            
                            Circle()
                                .fill(Color.green)
                                .frame(width: 8, height: 8)
                                .offset(x: 2, y: -2)
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
                
                // Recommendation
                HStack {
                    Text("Because you've shown interest in a similar community")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text("•••")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(.systemGray5)),
                    alignment: .bottom
                )
                
                // Post Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        HStack {
                            Image("placeholder")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .clipShape(Circle())
                            
                            Text("r/iqtest")
                                .foregroundColor(.black)
                            
                            Text("2d")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("Join")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 4)
                                .background(Color.blue)
                                .cornerRadius(20)
                        }
                    }
                    
                    Text("need help understanding this question")
                        .font(.system(size: 20, weight: .medium))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                
                // Post Content - Scrollable
                ScrollView {
                    VStack(spacing: 0) {
                        // IQ Test Question
                        VStack(spacing: 16) {
                            VStack(spacing: 16) {
                                Text("\"WATER\" is written as \"YCVFS\". How would you write \"EARTH\" in this code?")
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical, 8)
                                
                                VStack(spacing: 8) {
                                    ForEach(["A) FBSUI", "B) FDSUI", "C) GDSVI", "D) GDVTI"], id: \.self) { option in
                                        Text(option)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(8)
                            
                            // Explanatory notes
                            VStack(alignment: .leading, spacing: 8) {
                                Text("fire      water")
                                    .foregroundColor(.gray)
                                Text("gjsf      ycvfs")
                                    .foregroundColor(.gray)
                                Text("  1         2 1")
                                    .foregroundColor(.gray)
                                Text("earth")
                                    .foregroundColor(.gray)
                                Text("fbsui")
                                    .foregroundColor(.gray)
                                Text("A≠B      A=C")
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 8)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                        }
                        .padding(16)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 12)
                        
                        // Post Stats
                        HStack {
                            Button(action: {}) {
                                HStack {
                                    Text("⬆")
                                    Text("56")
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(.systemGray6))
                                .cornerRadius(20)
                            }
                            
                            Button(action: {}) {
                                HStack {
                                    Text("⬇")
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(.systemGray6))
                                .cornerRadius(20)
                            }
                            
                            Button(action: {}) {
                                HStack {
                                    Image(systemName: "message")
                                        .font(.system(size: 16))
                                    Text("285")
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(.systemGray6))
                                .cornerRadius(20)
                            }
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "bell")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 8)
                            
                            Button(action: {}) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                        
                        // Promoted Content
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image("placeholder")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                                
                                Text("u/Crypto_Com_Official")
                                    .foregroundColor(.black)
                                
                                Text("Promoted")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Text("•••")
                                    .font(.system(size: 18))
                                    .foregroundColor(.gray)
                            }
                            
                            Text("Stand to win 1 BTC every week by joining or referring a friend to Crypto.com Level Up!")
                                .font(.system(size: 18, weight: .medium))
                                .padding(.bottom, 8)
                            
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: 96)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 12)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.systemGray5)),
                            alignment: .top
                        )
                    }
                }
                
                // Bottom Navigation
                HStack {
                    // Home button
                    VStack {
                        Image(systemName: "house")
                            .font(.system(size: 24))
                        
                        Text("Home")
                            .font(.system(size: 12))
                            .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Answers button
                    VStack {
                        Image(systemName: "star")
                            .font(.system(size: 24))
                        
                        Text("Answers")
                            .font(.system(size: 12))
                            .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Create button with navigation link
                    NavigationLink(destination: RedditPostCreationView()) {
                        VStack {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 24))
                                .foregroundColor(.black) // Explicit color to ensure it's visible
                            
                            Text("Create")
                                .font(.system(size: 12))
                                .foregroundColor(.black) // Explicit color to ensure it's visible
                                .padding(.top, 4)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Chat button
                    VStack {
                        Image(systemName: "message")
                            .font(.system(size: 24))
                        
                        Text("Chat")
                            .font(.system(size: 12))
                            .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Inbox button with notification
                    VStack {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "bell")
                                .font(.system(size: 24))
                            
                            ZStack {
                                Circle()
                                    .fill(Color.orange)
                                    .frame(width: 16, height: 16)
                                
                                Text("1")
                                    .font(.system(size: 10))
                                    .foregroundColor(.white)
                            }
                            .offset(x: 4, y: -4)
                        }
                        
                        Text("Inbox")
                            .font(.system(size: 12))
                            .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 16)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(.systemGray5)),
                    alignment: .top
                )
            }
            .navigationBarHidden(true)
        }
    }
}


