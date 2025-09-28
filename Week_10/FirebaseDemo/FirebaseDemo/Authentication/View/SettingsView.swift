
import SwiftUI

struct SettingsView: View {
    @StateObject private var settingsViewModel = SettingsViewModel()
    @Binding var showSignUpScreen: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Button("LogOut") {
                    Task {
                        do {
                            try settingsViewModel.logOut()
                            showSignUpScreen = true
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView(showSignUpScreen: .constant(true))
}
