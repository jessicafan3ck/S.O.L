import SwiftUI
import Combine
import CoreLocation


struct MessageView: View {
    let message: Message
    let themeColor: Color
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if !message.isUser {
                OperatorAvatarView(themeColor: themeColor)
            }
            
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                if message.content.starts(with: "---") {
                    // System message
                    Text(message.content)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                } else {
                    // Regular message
                    VStack(alignment: .leading, spacing: 8) {
                        Text(message.content)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 12)
                            .background(
                                message.isUser ?
                                Color.blue.opacity(0.2) :
                                themeColor.opacity(0.1)
                            )
                            .foregroundColor(
                                message.isUser ?
                                Color.primary :
                                Color.primary
                            )
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(
                                        message.isUser ?
                                        Color.blue.opacity(0.3) :
                                        themeColor.opacity(0.3),
                                        lineWidth: 1
                                    )
                            )
                        
                        if !message.translation.isEmpty && message.translation != "Translating..." {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Translation")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                
                                Text(message.translation)
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 12)
                            .padding(.bottom, 4)
                        }
                    }
                    
                    HStack {
                        if !message.isUser {
                            Text("Operator")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text(message.timestamp, style: .time)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        if message.isUser {
                            Text("You")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
            if message.isUser {
                Spacer()
                UserAvatarView()
            }
        }
        .padding(.horizontal)
    }
}

struct UserAvatarView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 30, height: 30)
            
            Image(systemName: "person.fill")
                .font(.system(size: 14))
                .foregroundColor(.blue)
        }
    }
}

struct OperatorAvatarView: View {
    let themeColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(themeColor.opacity(0.2))
                .frame(width: 30, height: 30)
            
            Image(systemName: "phone.fill")
                .font(.system(size: 14))
                .foregroundColor(themeColor)
        }
    }
}

// MARK: - Preview Provider

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
};

struct Message: Identifiable, Equatable, Codable {
    let id: UUID
    let content: String
    let translation: String
    let isUser: Bool
    let timestamp: Date
    
    init(id: UUID = UUID(), content: String, translation: String, isUser: Bool, timestamp: Date = Date()) {
        self.id = id
        self.content = content
        self.translation = translation
        self.isUser = isUser
        self.timestamp = timestamp
    }
    
    // Implement Equatable
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id &&
        lhs.content == rhs.content &&
        lhs.translation == rhs.translation &&
        lhs.isUser == rhs.isUser
    }
}

enum TranslationDirection {
    case userToOperator
    case operatorToUser
}

// MARK: - View Models

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var inputMessage: String = ""
    @Published var isProcessing: Bool = false
    @Published var operatorLanguage: OperatorLanguage = .spanish {
        didSet {
            saveOperatorLanguage()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let geminiService = GeminiService()
    private let translationService = TranslationService()
    
    // Keys for UserDefaults
    private let messagesKey = "savedMessages"
    private let languageKey = "operatorLanguage"
    
    enum OperatorLanguage: String, CaseIterable, Identifiable, Codable {
        case spanish = "Spanish"
        case french = "French"
        case german = "German"
        case mandarin = "Mandarin"
        
        var id: String { self.rawValue }
        
        var themeColor: Color {
            switch self {
            case .spanish: return Color.red
            case .french: return Color.blue
            case .german: return Color(red: 0.1, green: 0.1, blue: 0.3)
            case .mandarin: return Color(red: 0.8, green: 0.2, blue: 0.2)
            }
        }
        
        var flagEmoji: String {
            switch self {
            case .spanish: return "🇪🇸"
            case .french: return "🇫🇷"
            case .german: return "🇩🇪"
            case .mandarin: return "🇨🇳"
            }
        }
    }
    
    init() {
        loadSavedData()
        
        // Add initial greeting if no messages exist
        if messages.isEmpty {
            addInitialGreeting()
        }
    }
    
    // MARK: - Persistence Methods
    
    private func loadSavedData() {
        // Load saved messages
        if let data = UserDefaults.standard.data(forKey: messagesKey) {
            do {
                let decodedMessages = try JSONDecoder().decode([Message].self, from: data)
                self.messages = decodedMessages
            } catch {
                print("Failed to decode messages: \(error)")
            }
        }
        
        // Load saved operator language
        if let languageString = UserDefaults.standard.string(forKey: languageKey),
           let savedLanguage = OperatorLanguage(rawValue: languageString) {
            self.operatorLanguage = savedLanguage
        }
    }
    
    private func saveMessages() {
        do {
            let data = try JSONEncoder().encode(messages)
            UserDefaults.standard.set(data, forKey: messagesKey)
        } catch {
            print("Failed to encode messages: \(error)")
        }
    }
    
    private func saveOperatorLanguage() {
        UserDefaults.standard.set(operatorLanguage.rawValue, forKey: languageKey)
    }
    
    func clearChatHistory() {
        messages.removeAll()
        saveMessages()
        addInitialGreeting()
    }
    
    // MARK: - Chat Methods
    
    func addInitialGreeting() {
        // Use a mock location for testing
        var userLocationInfo = "User coordinates: 40.7128, -74.0060 (Mock location: New York City)"
        
        // In a real app, you would use CLLocationManager to get the actual user location
        // let locationManager = CLLocationManager()
        // if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        //    CLLocationManager.authorizationStatus() == .authorizedAlways {
        //     if let location = locationManager.location {
        //         userLocationInfo = "User coordinates: \(location.coordinate.latitude), \(location.coordinate.longitude)"
        //     }
        // }
    
        // Get device information
        let deviceInfo = "Device: \(UIDevice.current.model), iOS \(UIDevice.current.systemVersion)"
        
        // Base greeting with user context
        let greeting = "911, what's your emergency?"
        let operatorContext = "Context: \(deviceInfo). \(userLocationInfo)"
        
        // Translate the greeting to the operator's language
        translationService.translate(text: greeting, from: "English", to: operatorLanguage.rawValue)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Translation error: \(error)")
                }
            }, receiveValue: { translatedGreeting in
                // Translate the context information
                self.translationService.translate(text: operatorContext, from: "English", to: self.operatorLanguage.rawValue)
                    .sink(receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            print("Context translation error: \(error)")
                            
                            // If context translation fails, just add the greeting
                            let newMessage = Message(
                                content: translatedGreeting,
                                translation: greeting,
                                isUser: false
                            )
                            self.messages.append(newMessage)
                            self.saveMessages()
                        }
                    }, receiveValue: { translatedContext in
                        // Add the greeting message with the context
                        let newMessage = Message(
                            content: translatedGreeting,
                            translation: greeting,
                            isUser: false
                        )
                        self.messages.append(newMessage)
                        
                        // Add the context as a system message (only visible to the operator)
                        let contextMessage = Message(
                            content: "--- \(translatedContext) ---",
                            translation: operatorContext,
                            isUser: false
                        )
                        self.messages.append(contextMessage)
                        self.saveMessages()
                    })
                    .store(in: &self.cancellables)
            })
            .store(in: &cancellables)
    }
    
    func sendMessage() {
        guard !inputMessage.isEmpty else { return }
        let userMessage = inputMessage
        inputMessage = ""
        isProcessing = true
        
        // First, add the user message to the chat
        // We'll initially add it without translation, then update it when translation completes
        let tempMessage = Message(content: userMessage, translation: "Translating...", isUser: true)
        messages.append(tempMessage)
        saveMessages()
        
        // For simplicity in debugging, we can optionally skip translation
        // and directly use simulated translation
        #if DEBUG
        if operatorLanguage == .spanish && userMessage.lowercased().contains("fire") {
            let simulatedTranslation = "Ayuda! Hay un fuego en mi casa!"
            self.updateLastUserMessageTranslation(simulatedTranslation)
            self.generateOperatorResponse(userMessage: userMessage, translatedUserMessage: simulatedTranslation)
            return
        }
        #endif
        
        // Step 1: Translate user message to operator language
        translationService.translate(text: userMessage, from: "English", to: operatorLanguage.rawValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Translation error: \(error)")
                    // Update the message with error
                    self.updateLastUserMessageTranslation("Translation failed: \(error.localizedDescription)")
                    
                    // Even if translation fails, try to generate a response
                    // Use a basic fallback like prefixing with language
                    let fallbackTranslation = "[\(self.operatorLanguage.rawValue)]: \(userMessage)"
                    self.generateOperatorResponse(userMessage: userMessage, translatedUserMessage: fallbackTranslation)
                }
            }, receiveValue: { translatedUserMessage in
                // Update the message with the translation
                self.updateLastUserMessageTranslation(translatedUserMessage)
                
                // Step 2: Generate operator response using Gemini
                self.generateOperatorResponse(userMessage: userMessage, translatedUserMessage: translatedUserMessage)
            })
            .store(in: &cancellables)
    }
    
    private func updateLastUserMessageTranslation(_ translation: String) {
        guard let lastIndex = messages.lastIndex(where: { $0.isUser }) else { return }
        let lastMessage = messages[lastIndex]
        let updatedMessage = Message(
            id: lastMessage.id, // Keep the same ID
            content: lastMessage.content,
            translation: translation,
            isUser: true,
            timestamp: lastMessage.timestamp // Keep the same timestamp
        )
        messages[lastIndex] = updatedMessage
        saveMessages()
    }
    
    private func generateOperatorResponse(userMessage: String, translatedUserMessage: String) {
        // For simplicity in debugging, we can use predefined responses
        #if DEBUG
        if operatorLanguage == .spanish && userMessage.lowercased().contains("fire") {
            let fakeResponse = "¿Cuál es su ubicación exacta? Estamos enviando a los bomberos ahora mismo."
            let fakeTranslation = "What is your exact location? We are sending firefighters right now."
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.addOperatorMessage(
                    content: fakeResponse,
                    translation: fakeTranslation
                )
                self.isProcessing = false
            }
            return
        }
        #endif
        
        // Create a prompt for Gemini that instructs it to act as a 911 operator
        // Analyze previous messages to determine if an emergency response should be dispatched
        var dispatchEmergencyServices = false
        var emergencyType = ""
        var location = ""
        
        // Check previous messages for emergency info and location details
        for message in messages where message.isUser {
            let lowerContent = message.content.lowercased()
            
            // Check for emergency types
            if lowerContent.contains("fire") || lowerContent.contains("burning") {
                emergencyType = "fire"
                dispatchEmergencyServices = true
            } else if lowerContent.contains("heart") || lowerContent.contains("pain") || lowerContent.contains("attack") {
                emergencyType = "medical"
                dispatchEmergencyServices = true
            } else if lowerContent.contains("accident") || lowerContent.contains("crash") {
                emergencyType = "accident"
                dispatchEmergencyServices = true
            }
            
            // Try to extract location information
            // This is a simple check - in a real app you'd want more sophisticated location extraction
            if lowerContent.contains("street") || lowerContent.contains("avenue") || lowerContent.contains("road") {
                // Extract a simple location from the message for demonstration
                location = message.content
            }
        }
        
        // Determine if we have enough information to dispatch services
        let shouldDispatch = dispatchEmergencyServices && !location.isEmpty
        
        let prompt = """
        You are a 911 emergency operator who speaks \(operatorLanguage.rawValue). 
        Respond to the following emergency call in \(operatorLanguage.rawValue).
        Keep your response concise and focused on gathering critical information, dispatching help, 
        or providing immediate guidance. Respond ONLY in \(operatorLanguage.rawValue).
        
        Context from previous messages in this conversation:
        Emergency type: \(emergencyType)
        Location information: \(location)
        
        \(shouldDispatch ? "IMPORTANT: The emergency services have been dispatched. Make sure to inform the caller that help is on the way." : "Continue gathering essential information and nature of emergency. Comfort users and let them know that S.O.L (the name of the app) has sent their location to the authorities")
        
        Caller's message (translated to \(operatorLanguage.rawValue)): \(translatedUserMessage)
        
        Your response (in \(operatorLanguage.rawValue)):
        """
        
        geminiService.generateContent(prompt: prompt)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Gemini API error: \(error)")
                    
                    // Generate a fallback response based on language
                    let fallbackResponse: String
                    
                    switch self.operatorLanguage {
                    case .spanish:
                        fallbackResponse = "¿Cuál es su emergencia? Por favor, dígame su ubicación."
                    case .french:
                        fallbackResponse = "Quelle est votre urgence? S'il vous plaît, donnez-moi votre emplacement."
                    case .german:
                        fallbackResponse = "Was ist Ihr Notfall? Bitte teilen Sie mir Ihren Standort mit."
                    case .mandarin:
                        fallbackResponse = "您有什么紧急情况？请告诉我您的位置。"
                    }
                    
                    self.addOperatorMessage(
                        content: fallbackResponse,
                        translation: "What is your emergency? Please tell me your location."
                    )
                    self.isProcessing = false
                }
            }, receiveValue: { operatorResponse in
                // Step 3: Translate operator response back to English
                self.translationService.translate(
                    text: operatorResponse,
                    from: self.operatorLanguage.rawValue,
                    to: "English"
                )
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Translation error: \(error)")
                        
                        // Add the operator message with a basic translation indication
                        self.addOperatorMessage(
                            content: operatorResponse,
                            translation: "[Translation unavailable - please check the original message]"
                        )
                        self.isProcessing = false
                    }
                }, receiveValue: { translatedResponse in
                    // Add the operator message with translation
                    self.addOperatorMessage(
                        content: operatorResponse,
                        translation: translatedResponse
                    )
                    self.isProcessing = false
                    
                    // If services were dispatched, log this action
                    if shouldDispatch {
                        print("Emergency services dispatched - Type: \(emergencyType), Location: \(location)")
                    }
                })
                .store(in: &self.cancellables)
            })
            .store(in: &cancellables)
    }
    
    private func addOperatorMessage(content: String, translation: String) {
        let operatorMessage = Message(
            content: content,
            translation: translation,
            isUser: false
        )
        messages.append(operatorMessage)
        saveMessages()
    }
    
    func changeOperatorLanguage(to language: OperatorLanguage) {
        guard operatorLanguage != language else { return }
        operatorLanguage = language
        
        // If changing language mid-conversation, add a new greeting
        if messages.count > 0 {
            messages.append(Message(
                content: "--- Operator language changed to \(language.rawValue) ---",
                translation: "",
                isUser: false
            ))
            saveMessages()
            addInitialGreeting()
        }
    }
    
    // For preview purposes - add sample messages
    func addSampleMessages() {
        messages.append(Message(
            content: "¿Cuál es su emergencia?",
            translation: "911, what's your emergency?",
            isUser: false
        ))
        
        messages.append(Message(
            content: "My house is on fire! I need help!",
            translation: "¡Mi casa está en fuego! ¡Necesito ayuda!",
            isUser: true
        ))
        
        messages.append(Message(
            content: "¿Cuál es su dirección? Estamos enviando bomberos inmediatamente.",
            translation: "What is your address? We are sending firefighters immediately.",
            isUser: false
        ))
        
        saveMessages()
    }
}

// MARK: - API Services

class GeminiService {
    private let apiKey = ""
    private let baseURL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent"
    
    func generateContent(prompt: String) -> AnyPublisher<String, Error> {
        guard let url = URL(string: "\(baseURL)?key=\(apiKey)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        // Create request body for Gemini API
        let requestBody: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        [
                            "text": prompt
                        ]
                    ]
                ]
            ],
            "generationConfig": [
                "temperature": 0.7,
                "topK": 40,
                "topP": 0.95,
                "maxOutputTokens": 1024,
            ]
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            return Fail(error: URLError(.cannotParseResponse)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30.0 // Increase timeout for reliability
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                // For debugging
                print("Gemini API Status Code: \(httpResponse.statusCode)")
                if let responseStr = String(data: data, encoding: .utf8) {
                    print("Response: \(responseStr)")
                }
                
                // Check for valid response
                if httpResponse.statusCode != 200 {
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .tryMap { data -> String in
                // Parse Gemini API response to extract the generated text
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let candidates = json["candidates"] as? [[String: Any]],
                   let firstCandidate = candidates.first,
                   let content = firstCandidate["content"] as? [String: Any],
                   let parts = content["parts"] as? [[String: Any]],
                   let firstPart = parts.first,
                   let text = firstPart["text"] as? String {
                    return text.trimmingCharacters(in: .whitespacesAndNewlines)
                } else {
                    // For debugging, print the full response
                    if let responseStr = String(data: data, encoding: .utf8) {
                        print("Failed to parse Gemini response: \(responseStr)")
                    }
                    throw URLError(.cannotParseResponse)
                }
            }
            .catch { error -> AnyPublisher<String, Error> in
                print("Gemini API error: \(error)")
                // Provide a fallback response
                return Just("Unable to generate response due to API error. Please try again.")
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

class TranslationService {
    private let apiKey = "YOUR_API_KEY_HERE"
    private let baseURL = "https://translation.googleapis.com/language/translate/v2"
    
    func translate(text: String, from sourceLanguage: String, to targetLanguage: String) -> AnyPublisher<String, Error> {
        return googleTranslate(text: text, from: sourceLanguage, to: targetLanguage)
            .catch { error -> AnyPublisher<String, Error> in
                print("Google Translate API error: \(error). Falling back to Gemini.")
                return self.geminiTranslate(text: text, from: sourceLanguage, to: targetLanguage)
                    .catch { error -> AnyPublisher<String, Error> in
                        print("Gemini translation fallback error: \(error). Using simple fallback.")
                        return Just("[\(targetLanguage)]: \(text)")
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func googleTranslate(text: String, from sourceLanguage: String, to targetLanguage: String) -> AnyPublisher<String, Error> {
        // Map language names to language codes
        let languageCodeMap = [
            "English": "en",
            "Spanish": "es",
            "French": "fr",
            "German": "de",
            "Mandarin": "zh"
        ]
        
        let sourceCode = languageCodeMap[sourceLanguage] ?? "en"
        let targetCode = languageCodeMap[targetLanguage] ?? "en"
        
        if sourceCode == targetCode {
            return Just(text)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        guard let url = URL(string: "\(baseURL)?key=\(apiKey)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let requestBody: [String: Any] = [
            "q": text,
            "source": sourceCode,
            "target": targetCode,
            "format": "text"
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            return Fail(error: URLError(.cannotParseResponse)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                // For debugging
                print("Translation API Status Code: \(httpResponse.statusCode)")
                if let responseStr = String(data: data, encoding: .utf8) {
                    print("Response: \(responseStr)")
                }
                
                // Check for valid response
                if httpResponse.statusCode != 200 {
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .tryMap { data -> String in
                // Parse Google Translate API response
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let dataDict = json["data"] as? [String: Any],
                   let translations = dataDict["translations"] as? [[String: Any]],
                   let firstTranslation = translations.first,
                   let translatedText = firstTranslation["translatedText"] as? String {
                    return translatedText
                } else {
                    throw URLError(.cannotParseResponse)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func geminiTranslate(text: String, from sourceLanguage: String, to targetLanguage: String) -> AnyPublisher<String, Error> {
        let prompt = """
        Translate the following text from \(sourceLanguage) to \(targetLanguage).
        Provide ONLY the translation with no additional text or explanation.
        
        Text to translate: \(text)
        """
        
        return GeminiService().generateContent(prompt: prompt)
    }
}


struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            AppHeader(viewModel: viewModel)
            
            // Messages
            ChatMessagesView(viewModel: viewModel)
            
            // Input area
            MessageInputView(viewModel: viewModel)
        }
        .background(Color(.systemBackground))
    }
}

struct AppHeader: View {
    @ObservedObject var viewModel: ChatViewModel
    @State private var showingSettings = false
    
    var body: some View {
        HStack {
            Image(systemName: "phone.fill.arrow.up.right")
                .font(.title2)
                .foregroundColor(.white)
                .padding(.trailing, 4)
            
            Text("911 Emergency Translator")
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            HStack(spacing: 4) {
                Text(viewModel.operatorLanguage.flagEmoji)
                    .font(.title3)
                
                Menu {
                    ForEach(ChatViewModel.OperatorLanguage.allCases) { language in
                        Button(action: {
                            viewModel.changeOperatorLanguage(to: language)
                        }) {
                            Label(language.rawValue, systemImage: language == viewModel.operatorLanguage ? "checkmark" : "")
                        }
                    }
                    
                    Divider()
                    
                    Button(role: .destructive, action: {
                        showingSettings = true
                    }) {
                        Label("Settings", systemImage: "gear")
                    }
                } label: {
                    HStack {
                        Text(viewModel.operatorLanguage.rawValue)
                            .foregroundColor(.white)
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(viewModel.operatorLanguage.themeColor.opacity(0.4))
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(viewModel.operatorLanguage.themeColor.gradient)
        .alert("Settings", isPresented: $showingSettings) {
            Button("Clear Chat History", role: .destructive) {
                viewModel.clearChatHistory()
            }
            
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Manage your emergency translator settings")
        }
    }
}

struct ChatMessagesView: View {
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView {
                LazyVStack(spacing: 16) {
                    // Date header
                    HStack {
                        VStack(alignment: .center) { Divider() }
                        Text(Date(), style: .date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                        VStack(alignment: .center) { Divider() }
                    }
                    .padding(.vertical, 8)
                    
                    ForEach(viewModel.messages) { message in
                        MessageView(message: message, themeColor: viewModel.operatorLanguage.themeColor)
                            .id(message.id)
                    }
                    
                    if viewModel.isProcessing {
                        HStack {
                            Spacer()
                            TypingIndicator(color: viewModel.operatorLanguage.themeColor)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(16)
                            Spacer()
                        }
                        .id("processing")
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical, 8)
            }
            .onChange(of: viewModel.messages) { oldValue, newValue in
                if let lastMessage = newValue.last {
                    withAnimation {
                        scrollView.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            .onChange(of: viewModel.isProcessing) { oldValue, newValue in
                if newValue {
                    withAnimation {
                        scrollView.scrollTo("processing", anchor: .bottom)
                    }
                }
            }
        }
    }
}

struct TypingIndicator: View {
    let color: Color
    @State private var animationState = 0
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
                    .opacity(animationState == index ? 1.0 : 0.4)
            }
        }
        .padding(8)
        .onAppear {
            let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
            _ = timer.sink { _ in
                withAnimation {
                    animationState = (animationState + 1) % 3
                }
            }
        }
    }
}

struct MessageInputView: View {
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            
            HStack {
                HStack {
                    Image(systemName: "keyboard")
                        .foregroundColor(.secondary)
                    
                    TextField("Type your emergency (in English)...", text: $viewModel.inputMessage)
                        .disabled(viewModel.isProcessing)
                }
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(20)
                
                Button(action: {
                    viewModel.sendMessage()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(viewModel.operatorLanguage.themeColor)
                }
                .disabled(viewModel.inputMessage.isEmpty || viewModel.isProcessing)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            Text("This is a simulation. In a real emergency, please call your local emergency number.")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 8)
                .padding(.horizontal)
        }
        .background(
            Color(.systemBackground)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
        )
    }
}
