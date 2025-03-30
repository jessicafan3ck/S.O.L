import SwiftUI
import LocalAuthentication

struct SettingsTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Custom tab bar
                HStack(spacing: 0) {
                    TabButton(title: "General", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    
                    TabButton(title: "Profile", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                    
                    TabButton(title: "Security", isSelected: selectedTab == 2) {
                        selectedTab = 2
                    }
                }
                .padding(.top, 10)
                
                // Tab content
                TabView(selection: $selectedTab) {
                    GeneralSettingsView()
                        .tag(0)
                    
                    ProfileSettingsView()
                        .tag(1)
                    
                    SecuritySettingsView()
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Custom tab button
struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? Color(red: 255/255, green: 125/255, blue: 69/255) : .gray)
                
                // Indicator
                Rectangle()
                    .fill(isSelected ? Color(red: 255/255, green: 125/255, blue: 69/255) : Color.clear)
                    .frame(height: 3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

// General settings tab
struct GeneralSettingsView: View {
    @AppStorage("appDisguise") private var appDisguise: String = "spotify"
    @AppStorage("triggerType") private var triggerType: String = "tap5"
    
    let appOptions = [
        ("spotify", "Spotify"),
        ("instagram", "Instagram"),
        ("tiktok", "TikTok"),
        ("reddit", "Reddit"),
        ("twitter", "Twitter")
    ]
    
    let triggerOptions = [
        ("tap5", "5x Tap Pattern"),
        ("hold3", "3-Second Hold"),
        ("pattern", "Gesture Pattern"),
        ("shake", "Shake Device")
    ]
    
    var body: some View {
        List {
            Section(header: Text("App Disguise")) {
                ForEach(appOptions, id: \.0) { option in
                    HStack {
                        Text(option.1)
                        Spacer()
                        if appDisguise == option.0 {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color(red: 255/255, green: 125/255, blue: 69/255))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        appDisguise = option.0
                    }
                }
            }
            
            Section(header: Text("Emergency Trigger")) {
                ForEach(triggerOptions, id: \.0) { option in
                    HStack {
                        Text(option.1)
                        Spacer()
                        if triggerType == option.0 {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color(red: 255/255, green: 125/255, blue: 69/255))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        triggerType = option.0
                    }
                }
            }
            
            Section(header: Text("Behavior")) {
                Toggle("Vibrate on Trigger", isOn: .constant(true))
                Toggle("Auto-call Emergency Contact", isOn: .constant(true))
                Toggle("Share Location", isOn: .constant(true))
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

// Profile settings tab
struct ProfileSettingsView: View {
    @State private var showEmergencyContacts = false
    @State private var showHealthProfile = false
    
    var body: some View {
        List {
            Section {
                // User info summary
                HStack(spacing: 15) {
                    Circle()
                        .fill(Color(red: 255/255, green: 125/255, blue: 69/255))
                        .frame(width: 70, height: 70)
                        .overlay(
                            Text("SL")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Sarah Lee")
                            .font(.system(size: 18, weight: .bold))
                        
                        Text("sarahlee@example.com")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 8)
            }
            
            Section(header: Text("Emergency Information")) {
                NavigationLink(destination: EmergencyContactsView(), isActive: $showEmergencyContacts) {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.exclamationmark")
                            .foregroundColor(Color(red: 255/255, green: 125/255, blue: 69/255))
                            .font(.system(size: 20))
                            .frame(width: 30)
                        
                        Text("Emergency Contacts")
                    }
                }
                
                Button(action: {
                    authenticateForHealthProfile()
                }) {
                    HStack {
                        Image(systemName: "heart.text.square")
                            .foregroundColor(Color(red: 255/255, green: 125/255, blue: 69/255))
                            .font(.system(size: 20))
                            .frame(width: 30)
                        
                        Text("Health Profile")
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                }
            }
            
            Section(header: Text("Account")) {
                NavigationLink(destination: Text("Account Details View")) {
                    HStack {
                        Image(systemName: "person.circle")
                            .foregroundColor(Color(red: 255/255, green: 125/255, blue: 69/255))
                            .font(.system(size: 20))
                            .frame(width: 30)
                        
                        Text("Account Details")
                    }
                }
                
                NavigationLink(destination: Text("Notification Preferences")) {
                    HStack {
                        Image(systemName: "bell")
                            .foregroundColor(Color(red: 255/255, green: 125/255, blue: 69/255))
                            .font(.system(size: 20))
                            .frame(width: 30)
                        
                        Text("Notifications")
                    }
                }
            }
            
            Section {
                Button(action: {
                    // Sign out logic
                }) {
                    HStack {
                        Spacer()
                        Text("Sign Out")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .sheet(isPresented: $showHealthProfile) {
            HealthProfileView()
        }
    }
    
    // Authentication for accessing health profile
    func authenticateForHealthProfile() {
        let context = LAContext()
        var error: NSError?
        
        // Check if biometric authentication is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Access your health information"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.showHealthProfile = true
                    } else {
                        // Handle authentication error
                        print("Authentication failed: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
            }
        } else {
            // Fallback to password if biometrics not available
            // In a real app, you would show a password entry screen
            showHealthProfile = true
        }
    }
}

// Security settings tab
struct SecuritySettingsView: View {
    @AppStorage("useBiometrics") private var useBiometrics = true
    @AppStorage("requirePasswordAfter") private var requirePasswordAfter = "immediately"
    @State private var showChangePassword = false
    
    let timeOptions = [
        ("immediately", "Immediately"),
        ("15min", "After 15 minutes"),
        ("1hour", "After 1 hour"),
        ("4hours", "After 4 hours"),
        ("1day", "After 1 day")
    ]
    
    var body: some View {
        List {
            Section(header: Text("Authentication")) {
                Toggle("Use Face ID / Touch ID", isOn: $useBiometrics)
                
                NavigationLink(destination: Text("Change Password View"), isActive: $showChangePassword) {
                    Text("Change Password")
                }
            }
            
            Section(header: Text("Auto-Lock")) {
                ForEach(timeOptions, id: \.0) { option in
                    HStack {
                        Text(option.1)
                        Spacer()
                        if requirePasswordAfter == option.0 {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color(red: 255/255, green: 125/255, blue: 69/255))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        requirePasswordAfter = option.0
                    }
                }
            }
            
            Section(header: Text("Emergency Access")) {
                Toggle("Allow Emergency Bypass", isOn: .constant(true))
                    .onTapGesture {
                        // Show info about this feature
                    }
                Text("When enabled, emergency services can access vital information even when the app is locked.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Section(header: Text("Data")) {
                Button(action: {
                    // Export data logic
                }) {
                    Text("Export My Data")
                }
                
                Button(action: {
                    // Clear data logic
                }) {
                    Text("Clear All Data")
                        .foregroundColor(.red)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

// Emergency contacts view
struct EmergencyContactsView: View {
    @State private var contacts = [
        EmergencyContact(id: "1", name: "John Smith", relationship: "Father", phone: "+1 (555) 123-4567", isEmergencyServices: false),
        EmergencyContact(id: "2", name: "Emergency Services", relationship: "911", phone: "911", isEmergencyServices: true),
        EmergencyContact(id: "3", name: "Jane Doe", relationship: "Sister", phone: "+1 (555) 987-6543", isEmergencyServices: false)
    ]
    @State private var showAddContact = false
    
    var body: some View {
        List {
            Section(header: Text("Call In Emergency")) {
                ForEach(contacts.sorted(by: { $0.isEmergencyServices && !$1.isEmergencyServices })) { contact in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(contact.name)
                                .font(.system(size: 16, weight: .medium))
                            
                            Text(contact.relationship)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        if contact.isEmergencyServices {
                            Text("PRIORITY")
                                .font(.system(size: 10, weight: .bold))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(4)
                        }
                    }
                }
                .onDelete { indexSet in
                    let sortedContacts = contacts.sorted(by: { $0.isEmergencyServices && !$1.isEmergencyServices })
                    for index in indexSet {
                        if let contactIndex = contacts.firstIndex(where: { $0.id == sortedContacts[index].id }) {
                            // Don't allow deletion of emergency services
                            if !contacts[contactIndex].isEmergencyServices {
                                contacts.remove(at: contactIndex)
                            }
                        }
                    }
                }
            }
            
            Button(action: {
                showAddContact = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Emergency Contact")
                }
            }
        }
        .navigationTitle("Emergency Contacts")
        .sheet(isPresented: $showAddContact) {
            Text("Add Contact View")
                .presentationDetents([.medium])
        }
    }
}

// Health profile view - password protected
struct HealthProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var healthProfile = HealthProfile(
        birthDate: Date(timeIntervalSince1970: 630000000), // Just a sample date
        bloodType: "O+",
        height: 175,
        weight: 70,
        allergies: ["Penicillin", "Peanuts"],
        medications: ["Lisinopril 10mg daily"],
        conditions: ["Asthma", "Hypertension"],
        emergencyNotes: "May need inhaler during asthma attacks."
    )
    @State private var editMode = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Basic Information")) {
                    HStack {
                        Text("Date of Birth")
                        Spacer()
                        if editMode {
                            DatePicker("", selection: $healthProfile.birthDate, displayedComponents: .date)
                                .labelsHidden()
                        } else {
                            Text(formattedDate(healthProfile.birthDate))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    HStack {
                        Text("Blood Type")
                        Spacer()
                        if editMode {
                            TextField("Blood Type", text: $healthProfile.bloodType)
                                .multilineTextAlignment(.trailing)
                        } else {
                            Text(healthProfile.bloodType)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    HStack {
                        Text("Height (cm)")
                        Spacer()
                        if editMode {
                            TextField("Height", value: $healthProfile.height, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        } else {
                            Text("\(healthProfile.height) cm")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    HStack {
                        Text("Weight (kg)")
                        Spacer()
                        if editMode {
                            TextField("Weight", value: $healthProfile.weight, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        } else {
                            Text("\(healthProfile.weight) kg")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section(header: Text("Medical Information")) {
                    NavigationLink(destination: StringListEditor(title: "Allergies", items: $healthProfile.allergies, editMode: editMode)) {
                        HStack {
                            Text("Allergies")
                            Spacer()
                            Text(healthProfile.allergies.isEmpty ? "None" : "\(healthProfile.allergies.count) items")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    NavigationLink(destination: StringListEditor(title: "Medications", items: $healthProfile.medications, editMode: editMode)) {
                        HStack {
                            Text("Medications")
                            Spacer()
                            Text(healthProfile.medications.isEmpty ? "None" : "\(healthProfile.medications.count) items")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    NavigationLink(destination: StringListEditor(title: "Medical Conditions", items: $healthProfile.conditions, editMode: editMode)) {
                        HStack {
                            Text("Medical Conditions")
                            Spacer()
                            Text(healthProfile.conditions.isEmpty ? "None" : "\(healthProfile.conditions.count) items")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section(header: Text("Emergency Notes")) {
                    if editMode {
                        TextEditor(text: $healthProfile.emergencyNotes)
                            .frame(minHeight: 100)
                    } else {
                        Text(healthProfile.emergencyNotes.isEmpty ? "No emergency notes" : healthProfile.emergencyNotes)
                            .foregroundColor(healthProfile.emergencyNotes.isEmpty ? .gray : .primary)
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        Text("Last Updated: \(formattedDate(Date()))")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Health Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Done")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editMode.toggle()
                    }) {
                        Text(editMode ? "Save" : "Edit")
                    }
                }
            }
        }
    }
    
    // Format date to string
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// Editor for string lists (allergies, medications, conditions)
struct StringListEditor: View {
    let title: String
    @Binding var items: [String]
    let editMode: Bool
    @State private var newItem = ""
    
    var body: some View {
        List {
            if editMode {
                Section {
                    HStack {
                        TextField("Add new \(title.lowercased())", text: $newItem)
                        
                        Button(action: {
                            if !newItem.isEmpty {
                                items.append(newItem)
                                newItem = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color(red: 255/255, green: 125/255, blue: 69/255))
                        }
                    }
                }
            }
            
            Section {
                if items.isEmpty {
                    Text("No \(title.lowercased()) added")
                        .foregroundColor(.gray)
                        .italic()
                } else {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete(perform: editMode ? deleteItems : nil)
                }
            }
        }
        .navigationTitle(title)
    }
    
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

// Models
struct EmergencyContact: Identifiable {
    let id: String
    let name: String
    let relationship: String
    let phone: String
    let isEmergencyServices: Bool
}

struct HealthProfile {
    var birthDate: Date
    var bloodType: String
    var height: Int
    var weight: Int
    var allergies: [String]
    var medications: [String]
    var conditions: [String]
    var emergencyNotes: String
}

struct SettingsTabView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTabView()
    }
}
