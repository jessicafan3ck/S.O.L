import SwiftUI

struct InstagramSearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Search Header
            VStack(spacing: 0) {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22))
                    }
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        
                        TextField("", text: $searchText)
                            .padding(.vertical, 8)
                        
                        Button(action: {}) {
                            Image(systemName: "mic")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 8)
                    }
                    .background(Color(.systemGray5))
                    .cornerRadius(20)
                    .padding(.horizontal, 8)
                    
                    Button(action: {}) {
                        Text("Search")
                            .foregroundColor(.pink)
                            .fontWeight(.medium)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(Color(.systemGray6))
            }
            
            // Search Results
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // You may like header
                    HStack {
                        Text("You may like")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 14))
                                Text("Refresh")
                            }
                            .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    
                    // Results list
                    VStack(spacing: 0) {
                        // Real Natalia Grace (trending)
                        HStack {
                            HStack {
                                Circle()
                                    .fill(Color.pink)
                                    .frame(width: 8, height: 8)
                                    .padding(.trailing, 12)
                                
                                VStack(alignment: .leading) {
                                    Text("Real Natalia Grace")
                                        .font(.system(size: 18))
                                        .foregroundColor(.pink)
                                        .fontWeight(.medium)
                                    
                                    HStack {
                                        Image(systemName: "chart.line.uptrend.xyaxis")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                        Text("Trending")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 8) {
                                Image("placeholder")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .cornerRadius(6)
                                
                                Image("placeholder")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .cornerRadius(6)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.systemGray6))
                                .offset(y: 30),
                            alignment: .bottom
                        )
                        
                        // Steffanos (recent search)
                        HStack {
                            HStack {
                                Circle()
                                    .fill(Color.pink)
                                    .frame(width: 8, height: 8)
                                    .padding(.trailing, 12)
                                
                                VStack(alignment: .leading) {
                                    Text("Steffanos")
                                        .font(.system(size: 18))
                                        .foregroundColor(.pink)
                                        .fontWeight(.medium)
                                    
                                    Text("Recent search")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                            
                            Image("placeholder")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.systemGray6))
                                .offset(y: 30),
                            alignment: .bottom
                        )
                        
                        // alice makeup (recent search)
                        HStack {
                            HStack {
                                Circle()
                                    .fill(Color(.systemGray3))
                                    .frame(width: 8, height: 8)
                                    .padding(.trailing, 12)
                                
                                VStack(alignment: .leading) {
                                    Text("alice makeup")
                                        .font(.system(size: 18))
                                    
                                    Text("Recent search")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                            
                            Image("placeholder")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.systemGray6))
                                .offset(y: 30),
                            alignment: .bottom
                        )
                        
                        // hotpot meets bbq ithaca
                        HStack {
                            HStack {
                                Circle()
                                    .fill(Color(.systemGray3))
                                    .frame(width: 8, height: 8)
                                    .padding(.trailing, 12)
                                
                                Text("hotpot meets bbq ithaca")
                                    .font(.system(size: 18))
                            }
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.systemGray6))
                                .offset(y: 30),
                            alignment: .bottom
                        )
                        
                        // RIP Mikayla
                        HStack {
                            HStack {
                                Circle()
                                    .fill(Color(.systemGray3))
                                    .frame(width: 8, height: 8)
                                    .padding(.trailing, 12)
                                
                                Text("RIP Mikayla")
                                    .font(.system(size: 18))
                            }
                            
                            Spacer()
                            
                            Image("placeholder")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.systemGray6))
                                .offset(y: 30),
                            alignment: .bottom
                        )
                        
                        // daniela ortiz
                        HStack {
                            HStack {
                                Circle()
                                    .fill(Color(.systemGray3))
                                    .frame(width: 8, height: 8)
                                    .padding(.trailing, 12)
                                
                                Text("daniela ortiz")
                                    .font(.system(size: 18))
                            }
                            
                            Spacer()
                            
                            Image("placeholder")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.systemGray6))
                                .offset(y: 30),
                            alignment: .bottom
                        )
                        
                        // eid mubarak
                        HStack {
                            HStack {
                                Circle()
                                    .fill(Color(.systemGray3))
                                    .frame(width: 8, height: 8)
                                    .padding(.trailing, 12)
                                
                                Text("eid mubarak")
                                    .font(.system(size: 18))
                            }
                            
                            Spacer()
                            
                            Image("placeholder")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.systemGray6))
                                .offset(y: 30),
                            alignment: .bottom
                        )
                        
                        // brian cornell
                        HStack {
                            HStack {
                                Circle()
                                    .fill(Color(.systemGray3))
                                    .frame(width: 8, height: 8)
                                    .padding(.trailing, 12)
                                
                                Text("brian cornell")
                                    .font(.system(size: 18))
                            }
                            
                            Spacer()
                            
                            Image("placeholder")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.systemGray6))
                                .offset(y: 30),
                            alignment: .bottom
                        )
                    }
                }
            }
        }
    }
}

