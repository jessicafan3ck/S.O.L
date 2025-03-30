import SwiftUI
import Speech

struct EmergencyInputView: View {
    let appDisguise: AppDisguise?
    @State private var emergencyActivated = false
    @State private var showConfirmation = false
    @State private var showInputOptions = false
    @State private var longPressInProgress = false
    @State private var longPressDuration: CGFloat = 0
    @State private var emergencyDescription = ""
    
    @State private var isRecording = false
    @State private var recordingTimer: Timer?
    @State private var recordingSeconds = 0
    @State private var recognizedText = ""
    @State private var audioRecorder: AVAudioRecorder?
    @State private var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    @State private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State private var recognitionTask: SFSpeechRecognitionTask?
    
    @State private var dispatchInProgress = false
    @State private var countdown = 5
    @State private var countdownTimer: Timer?
    @GestureState private var isDetectingLongPress = false
    @State private var completedLongPress = false
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(
                            Color.gray.opacity(0.3),
                            lineWidth: 8
                        )
                        .frame(width: 200, height: 200)
                    
                    Circle()
                        .trim(from: 0.0, to: longPressInProgress ? longPressDuration : 0)
                        .stroke(
                            Color(red: 255/255, green: 75/255, blue: 51/255),
                            style: StrokeStyle(
                                lineWidth: 8,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))
                        .frame(width: 200, height: 200)
                        .animation(.linear, value: longPressDuration)
                    
                    VStack {
                        Text("S.O.L")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(longPressInProgress ? .red : Color(red: 255/255, green: 125/255, blue: 69/255))
                        
                        Text(longPressInProgress ? "Hold..." : "Press & Hold")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .frame(width: 180, height: 180)
                    .background(Color(UIColor.systemBackground))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                .onLongPressGesture(minimumDuration: 3.0, pressing: { isPressing in
                    longPressInProgress = isPressing
                    
                    if isPressing {
                        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                            if longPressInProgress {
                                withAnimation(.linear(duration: 0.01)) {
                                    longPressDuration += 0.003
                                }
                                
                                if longPressDuration >= 1.0 {
                                    timer.invalidate()
                                    longPressDuration = 1.0
                                }
                            } else {
                                timer.invalidate()
                                longPressDuration = 0
                            }
                        }
                    }
                }, perform: {
                    hapticFeedback.notificationOccurred(.success)
                    impactFeedback.impactOccurred()
                    withAnimation {
                        showConfirmation = true
                    }
                })
                
                Spacer()
                
                Text("Emergency mode will be activated after holding for 3 seconds")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
            }
            
            if showConfirmation {
                confirmationOverlay
            }
            
            if showInputOptions {
                inputOptionsOverlay
            }
            
            if dispatchInProgress {
                dispatchOverlay
            }
        }
    }
    
    var confirmationOverlay: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    cancelEmergency()
                }
            
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.red)
                
                Text("Activate Emergency Mode?")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
                Text("This will alert your emergency contacts and share your location with them.")
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                HStack(spacing: 20) {
                    Button(action: cancelEmergency) {
                        Text("Cancel")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .frame(width: 120)
                            .padding(.vertical, 12)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(12)
                    }
                    
                    Button(action: confirmEmergency) {
                        Text("Confirm")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 120)
                            .padding(.vertical, 12)
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                }
                .padding(.top, 10)
            }
            .padding(30)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 30)
        }
    }
    
    var inputOptionsOverlay: some View {
        ZStack {

            Color(red: 255/255, green: 50/255, blue: 50/255)
                .opacity(0.95)
                .ignoresSafeArea()
                .onTapGesture {
                }
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("EMERGENCY MODE ACTIVE")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()

                    Circle()
                        .fill(Color.white)
                        .frame(width: 12, height: 12)
                        .modifier(PulsingEffect())
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)
                .padding(.bottom, 20)
                
                ScrollView {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Describe your situation:")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                            
                            TextEditor(text: $emergencyDescription)
                                .foregroundColor(.black)
                                .frame(minHeight: 120)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                )
                                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
                                .onChange(of: emergencyDescription) { newValue in
                                    if isRecording {
                                        emergencyDescription = recognizedText
                                    }
                                }
                        }
                        .padding(.horizontal, 20)

                        VStack(spacing: 15) {
                            Button(action: toggleRecording) {
                                ZStack {
                                    Circle()
                                        .fill(isRecording ? Color.white : Color.white.opacity(0.3))
                                        .frame(width: 70, height: 70)
                                    
                                    if isRecording {
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: 30, height: 30)
                                    } else {
                                        Image(systemName: "mic.fill")
                                            .font(.system(size: 30))
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            
                            Text(isRecording ? "Recording... \(recordingSeconds)s" : "Hold to speak")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 10)

                        if !recognizedText.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Recognized Speech:")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.8))
                                
                                Text(recognizedText)
                                    .padding(10)
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(8)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 20)
                        }

                        Button(action: processEmergency) {
                            Text("Send Emergency Alert")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)

                        Button(action: cancelEmergency) {
                            Text("Cancel")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                        }
                        .padding(.bottom, 30)
                    }
                    .padding(.vertical, 20)
                }
            }
        }
    }

    var dispatchOverlay: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                        .frame(width: 120, height: 120)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(countdown) / 5.0)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .frame(width: 120, height: 120)
                        .animation(.linear, value: countdown)
                    
                    Text("\(countdown)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text("Dispatching Emergency Services")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                
                if !emergencyDescription.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your description:")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text(emergencyDescription)
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                }
                
                Text("Help is on the way")
                    .font(.system(size: 18))
                    .foregroundColor(.white.opacity(0.8))

                Button(action: cancelEmergency) {
                    Text("Cancel (Testing Only)")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.vertical, 10)
                }
                .padding(.top, 40)
            }
            .padding(30)
        }
    }
    
    func cancelEmergency() {
        withAnimation {
            showConfirmation = false
            showInputOptions = false
            dispatchInProgress = false
            longPressInProgress = false
            isRecording = false
            stopRecording()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            longPressDuration = 0
            emergencyDescription = ""
            recognizedText = ""
            recordingSeconds = 0
            countdown = 5
            countdownTimer?.invalidate()
        }
    }

    func confirmEmergency() {
        hapticFeedback.notificationOccurred(.success)
        
        withAnimation {
            showConfirmation = false
            showInputOptions = true
        }
    }

    func toggleRecording() {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }

    func startRecording() {
        isRecording = true
        recordingSeconds = 0

        recordingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            recordingSeconds += 1
        }

        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            if isRecording {
                let phrases = [
                    "I need help",
                    "I'm in an emergency situation",
                    "I don't feel safe",
                    "There's someone following me",
                    "I need medical assistance",
                    "I'm lost and need help",
                    "I'm in danger"
                ]
                
                if recognizedText.isEmpty {
                    recognizedText = phrases.randomElement() ?? "I need help"
                } else {
                    if Bool.random() && recognizedText.count < 100 {
                        recognizedText += " " + (phrases.randomElement() ?? "")
                    }
                }

                emergencyDescription = recognizedText
            } else {
                timer.invalidate()
            }
        }
    }
    
    func stopRecording() {
        isRecording = false
        recordingTimer?.invalidate()
    }

    func processEmergency() {
        withAnimation {
            showInputOptions = false
            dispatchInProgress = true
        }

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    cancelEmergency()
                }
            }
        }
        
    }
}

struct PulsingEffect: ViewModifier {
    @State private var pulsate = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(pulsate ? 1.2 : 0.8)
            .opacity(pulsate ? 1.0 : 0.6)
            .animation(Animation.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: pulsate)
            .onAppear {
                pulsate = true
            }
    }
}
