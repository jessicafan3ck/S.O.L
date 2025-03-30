import SwiftUI

struct RedditPostCreationView: View {
    @State private var title: String = ""
    @State private var bodyText: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {}) {
                    Image(systemName: "xmark")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Post")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray5))
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color(.systemGray5)),
                alignment: .bottom
            )
            
            // Community Selector
            HStack {
                Button(action: {}) {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 24, height: 24)
                            
                            Text("r/")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                        
                        Text("Select a community")
                            .foregroundColor(.black)
                            .padding(.leading, 8)
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray5))
                    .cornerRadius(20)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            // Post Content
            VStack(alignment: .leading, spacing: 12) {
                // Title input with left border
                HStack(alignment: .top, spacing: 8) {
                    Rectangle()
                        .fill(Color(.systemGray))
                        .frame(width: 4)
                    
                    TextField("Title", text: $title)
                        .font(.system(size: 20))
                }
                .padding(.bottom, 8)
                
                // Body text
                TextEditor(text: $bodyText)
                    .foregroundColor(bodyText.isEmpty ? .gray : .black)
                    .overlay(
                        VStack {
                            HStack {
                                if bodyText.isEmpty {
                                    Text("body text (optional)")
                                        .foregroundColor(.gray)
                                        .padding(.top, 8)
                                        .padding(.leading, 5)
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                    )
                    .frame(height: 128)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Spacer()
            
            // Bottom Controls
            HStack(spacing: 24) {
                Button(action: {}) {
                    Image(systemName: "photo")
                        .font(.system(size: 24))
                }
                
                Button(action: {}) {
                    Image(systemName: "video")
                        .font(.system(size: 24))
                }
                
                Button(action: {}) {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 24))
                }
                
                Button(action: {}) {
                    Image(systemName: "message")
                        .font(.system(size: 24))
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color(.systemGray5)),
                alignment: .top
            )
        }

    }
}
