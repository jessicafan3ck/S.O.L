import SwiftUI
import Combine

struct SpotifySearchView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showNotification = false
    @State private var notificationText = ""
    @State private var translatedText = ""
    @State private var cancellables = Set<AnyCancellable>()
    
    // Services - create lazily to avoid initialization errors
    private var geminiService: GeminiService {
        let service = GeminiService()
        return service
    }
    
    private var translationService: TranslationService {
        let service = TranslationService()
        return service
    }
    
    var body: some View {
        ZStack {
            // Main content
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 0) {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.leading, 8)
                            
                            TextField("What do you want to listen to?", text: $searchText, onCommit: {
                                performSearch()
                            })
                            .foregroundColor(.white)
                            
                            if !searchText.isEmpty {
                                Button(action: {
                                    searchText = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        .background(Color(UIColor.darkGray))
                        .cornerRadius(20)
                        
                        Button("Cancel") {
                            searchText = ""
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
                        
                        // Search history items (existing code)
                        // Pop 2008-2012
                        recentSearchItem(title: "Call: Yes", subtitle: "Playlist", isRounded: false)
                        
                        // B.A.P
                        recentSearchItem(title: "Call: No", subtitle: "Artist", isRounded: true)
                        
                        // JJK Openings/Endings
                        recentSearchItem(title: "Listen: Yes", subtitle: "Playlist", isRounded: false)
                        
                        // 青のすみか
                        recentSearchItem(title: "Listen: No", subtitle: "Song", isRounded: false)
                        
                        // 燈
                        recentSearchItem(title: "燈", subtitle: "Song • Soushi Sakiyama", isRounded: false)
                        
                        // If I Am With You
                        recentSearchItem(title: "If I Am With You", subtitle: "Song • 照井順政", isRounded: false)
                        
                        // Waka Waka
                        recentSearchItem(title: "Waka Waka (This Time for Africa) [The Official 2...]",
                                         subtitle: "Song • Shakira, Freshlyground",
                                         isRounded: false)
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color.black)
            .foregroundColor(.white)
            
            // Notification overlay
            if showNotification {
                VStack {
                    NotificationBanner(text: notificationText, translatedText: translatedText, onDismiss: {
                        withAnimation {
                            showNotification = false
                        }
                    })
                    .transition(.move(edge: .top))
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .zIndex(100)
            }
            
            // Loading indicator
            if isSearching {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                    )
                    .zIndex(101)
            }
        }
    }
    
    // Helper function to create recent search items
    private func recentSearchItem(title: String, subtitle: String, isRounded: Bool) -> some View {
        HStack {
            HStack {
                Image("placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 56, height: 56)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(isRounded ? 28 : 4)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .fontWeight(.semibold)
                    
                    Text(subtitle)
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
    
    // Function to perform search with Gemini API
    private func performSearch() {
        guard !searchText.isEmpty else { return }
        
        // Store search text locally to avoid capture issues
        let currentSearchText = searchText
        
        // Run on main thread
        DispatchQueue.main.async {
            self.isSearching = true
        }
        let translatedUserMessage = translationService.translate(text: currentSearchText, from: "English", to: "Spanish")

        // Gemini prompt
        let prompt = """
        You are a 911 emergency operator who speaks french. 
        Respond to the following emergency call in french.
        Keep your response concise and focused on gathering critical information, dispatching help, 
        or providing immediate guidance. Respond ONLY in french.
                
        "IMPORTANT: The emergency services have been dispatched. Make sure to inform the caller that help is on the way." : "Continue gathering essential information and nature of emergency. Comfort users and let them know that S.O.L (the name of the app) has sent their location to the authorities"). KEEP YOUR RESPONSES SHORT SO IT FITS INSIDE A NOTIFICATION
        
        Caller's message (translated to french): \(translatedUserMessage)
        
        """

        
        // Create a safety timeout
        let timeoutPublisher = Just(())
            .delay(for: .seconds(15), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .flatMap { _ -> AnyPublisher<(String, String), Error> in
                return Fail(error: NSError(domain: "com.spotify.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "Request timed out"]))
                    .eraseToAnyPublisher()
            }
        
        // Call Gemini API with proper error handling
        let requestPublisher = geminiService.generateContent(prompt: prompt)
            .catch { error -> AnyPublisher<String, Error> in
                // Handle Gemini API specific errors
                print("Gemini API error: \(error)")
                return Just("I couldn't process your music query right now.")
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .flatMap { geminiResponse -> AnyPublisher<(String, String), Error> in
                // Get the Gemini response then translate it
                return translationService.translate(text: geminiResponse, from: "French", to: "English")
                    .catch { error -> AnyPublisher<String, Error> in
                        // If translation fails, provide a default translation
                        print("Translation error: \(error)")
                        return Just("No se pudo traducir la respuesta.")
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    .map { translatedText in
                        return (geminiResponse, translatedText)
                    }
                    .eraseToAnyPublisher()
            }
        
        // Use the first publisher to complete (either the request or the timeout)
        Publishers.Merge(requestPublisher, timeoutPublisher)
            .first()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    // Always ensure we stop the loading indicator
                    DispatchQueue.main.async {
                        isSearching = false
                    }
                    
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        // Handle error
                        print("Error in search pipeline: \(error.localizedDescription)")
                        
                        DispatchQueue.main.async {
                            notificationText = "Sorry, couldn't process your search."
                            translatedText = "Lo siento, no pude procesar tu búsqueda."
                            
                            withAnimation {
                                showNotification = true
                            }
                            
                            // Auto-dismiss after 5 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                withAnimation {
                                    showNotification = false
                                }
                            }
                        }
                    }
                },
                receiveValue: { (originalResponse, translatedResponse) in
                    DispatchQueue.main.async {
                        notificationText = originalResponse
                        translatedText = translatedResponse
                        
                        // Show notification
                        withAnimation {
                            showNotification = true
                        }
                        
                        // Auto-dismiss after 5 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation {
                                showNotification = false
                            }
                        }
                    }
                }
            )
            .store(in: &cancellables)
    }
}

// Notification Banner View
struct NotificationBanner: View {
    let text: String
    let translatedText: String
    let onDismiss: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // App icon
            Image(systemName: "music.note.list")
                .font(.system(size: 20))
                .padding(8)
                .background(Color.purple)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Content
            VStack(alignment: .leading, spacing: 2) {
                // App name and time
                HStack {
                    Text("Music")
                        .font(.system(size: 13, weight: .semibold))
                    
                    Spacer()
                    
                    Text("now")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                
                // Main content
                Text(text)
                    .font(.system(size: 15))
                    .lineLimit(2)
                    .padding(.top, 1)
                
                // Translation
                Text(translatedText)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .padding(.top, 1)
            }
            
            // Close button
            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            .padding(.top, 2)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
        .preferredColorScheme(.light) // Force light appearance for notification
    }
}

// Preview provider
struct SpotifySearchView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifySearchView()
            .preferredColorScheme(.dark)
    }
}
