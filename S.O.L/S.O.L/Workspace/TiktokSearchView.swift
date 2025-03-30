import SwiftUI

struct TikTokSearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 0) {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24))
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
            
            // Content
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Recent Searches
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(["Bama", "emily rath", "tbr"], id: \.self) { search in
                            HStack {
                                HStack {
                                    Image(systemName: "clock")
                                        .foregroundColor(.gray)
                                        .frame(width: 20, height: 20)
                                        .padding(.trailing, 12)
                                    
                                    Text(search)
                                        .font(.system(size: 18))
                                }
                                
                                Spacer()
                                
                                Button(action: {}) {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 20))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        
                        Button(action: {}) {
                            HStack {
                                Text("See more")
                                    .foregroundColor(.gray)
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    
                    // You may like
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("You may like")
                                .font(.system(size: 20, weight: .bold))
                            
                            Spacer()
                            
                            Button(action: {}) {
                                HStack {
                                    Image(systemName: "arrow.counterclockwise")
                                        .font(.system(size: 14))
                                    Text("Refresh")
                                }
                                .foregroundColor(.gray)
                            }
                        }
                        .padding(.bottom, 12)
                        
                        // Search suggestions list
                        VStack(spacing: 16) {
                            // gemini
                            HStack(alignment: .top) {
                                Circle()
                                    .fill(Color.pink)
                                    .frame(width: 8, height: 8)
                                    .padding(.top, 6)
                                    .padding(.trailing, 12)
                                
                                VStack(alignment: .leading) {
                                    Text("gemini")
                                        .font(.system(size: 18))
                                    Text("Just watched")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            // haley passing away
                            HStack(alignment: .top) {
                                Circle()
                                    .fill(Color.pink)
                                    .frame(width: 8, height: 8)
                                    .padding(.top, 6)
                                    .padding(.trailing, 12)
                                
                                Text("haley passing away")
                                    .font(.system(size: 18))
                                    .foregroundColor(.pink.opacity(0.8))
                            }
                            
                            // Rachel Zegler
                            HStack(alignment: .top) {
                                Circle()
                                    .fill(Color(.systemGray3))
                                    .frame(width: 8, height: 8)
                                    .padding(.top, 6)
                                    .padding(.trailing, 12)
                                
                                VStack(alignment: .leading) {
                                    Text("Rachel Zegler Has Been Fired From Disney")
                                        .font(.system(size: 18))
                                    
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
                            
                            // blue lock
                            HStack(alignment: .top) {
                                Circle()
                                    .fill(Color(.systemGray3))
                                    .frame(width: 8, height: 8)
                                    .padding(.top, 6)
                                    .padding(.trailing, 12)
                                
                                Text("blue lock chapter 290")
                                    .font(.system(size: 18))
                            }
                            
                            // ENTJ CORE
                            HStack(alignment: .top) {
                                Circle()
                                    .fill(Color(.systemGray3))
                                    .frame(width: 8, height: 8)
                                    .padding(.top, 6)
                                    .padding(.trailing, 12)
                                
                                Text("ENTJ CORE")
                                    .font(.system(size: 18))
                            }
                            
                            // Molly Noblitt
                            HStack(alignment: .top) {
                                Circle()
                                    .fill(Color(.systemGray3))
                                    .frame(width: 8, height: 8)
                                    .padding(.top, 6)
                                    .padding(.trailing, 12)
                                
                                VStack(alignment: .leading) {
                                    Text("Molly Noblitt Pregnancy Announcement")
                                        .font(.system(size: 18))
                                    
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
                            
                            // kylie
                            HStack(alignment: .top) {
                                Circle()
                                    .fill(Color(.systemGray3))
                                    .frame(width: 8, height: 8)
                                    .padding(.top, 6)
                                    .padding(.trailing, 12)
                                
                                Text("kylie confirms breakup with timothee")
                                    .font(.system(size: 18))
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(.systemGray5)),
                        alignment: .top
                    )
                }
            }
            

        }

    }
}
