import SwiftUI

// MARK: - SpotifySearchView
struct SpotifySearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 0) {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        
                        TextField("What do you want to listen to?", text: $searchText)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 8)
                    .background(Color(UIColor.darkGray))
                    .cornerRadius(20)
                    
                    Button("Cancel") {
                        // Cancel action
                    }
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            
            // Recent searches
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Recent searches")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    
                    // Pop 2008-2012
                    HStack {
                        HStack {
                            Image("placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 56, height: 56)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(4)
                                .padding(.trailing, 8)
                            
                            VStack(alignment: .leading) {
                                Text("Call: Yes")
                                    .fontWeight(.semibold)
                                
                                Text("Playlist")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Remove action
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    // B.A.P
                    HStack {
                        HStack {
                            Image("placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 56, height: 56)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(28)
                                .padding(.trailing, 8)
                            
                            VStack(alignment: .leading) {
                                Text("Call: No")
                                    .fontWeight(.semibold)
                                
                                Text("Artist")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Remove action
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    // JJK Openings/Endings
                    HStack {
                        HStack {
                            Image("placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 56, height: 56)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(4)
                                .padding(.trailing, 8)
                            
                            VStack(alignment: .leading) {
                                Text("Listen: Yes")
                                    .fontWeight(.semibold)
                                
                                Text("Playlist")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Remove action
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    // 青のすみか
                    HStack {
                        HStack {
                            Image("placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 56, height: 56)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(4)
                                .padding(.trailing, 8)
                            
                            VStack(alignment: .leading) {
                                Text("Listen: No")
                                    .fontWeight(.semibold)
                                
                                Text("Song")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Remove action
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    // 燈
                    HStack {
                        HStack {
                            Image("placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 56, height: 56)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(4)
                                .padding(.trailing, 8)
                            
                            VStack(alignment: .leading) {
                                Text("燈")
                                    .fontWeight(.semibold)
                                
                                Text("Song • Soushi Sakiyama")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Remove action
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    // If I Am With You
                    HStack {
                        HStack {
                            Image("placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 56, height: 56)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(4)
                                .padding(.trailing, 8)
                            
                            VStack(alignment: .leading) {
                                Text("If I Am With You")
                                    .fontWeight(.semibold)
                                
                                Text("Song • 照井順政")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Remove action
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    // Waka Waka
                    HStack {
                        HStack {
                            Image("placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 56, height: 56)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(4)
                                .padding(.trailing, 8)
                            
                            VStack(alignment: .leading) {
                                Text("Waka Waka (This Time for Africa) [The Official 2...")
                                    .fontWeight(.semibold)
                                
                                Text("Song • Shakira, Freshlyground")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Remove action
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .padding(.horizontal)
            }
        }
        .background(Color.black)
        .foregroundColor(.white)
    }
}

