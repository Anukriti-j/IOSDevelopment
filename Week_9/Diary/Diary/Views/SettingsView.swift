import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("App Preferences")) {
                    Picker("Theme",selection: $settingsViewModel.selectedTheme) {
                        ForEach(Theme.allCases) { theme in
                            Text(theme.rawValue).tag(theme)
                        }
                    }
                    .onChange(of: settingsViewModel.selectedTheme) {
                        settingsViewModel.saveSelectedTheme()
                    }
                }
                Section {
                    Button("Reset Settings") {
                        settingsViewModel.resetSettings()
                        print("Reset Settings tapped")
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

//#Preview {
//    SettingsView(settingsViewModel: SettingsViewModel())
//}
