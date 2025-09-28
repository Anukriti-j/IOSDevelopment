
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var settingsViewModel: SettingsViewModel
    
    var body: some View {
        Form {
            Picker("Theme",selection: $settingsViewModel.selectedTheme) {
                ForEach(Theme.allCases) { theme in
                    Text(theme.rawValue).tag(theme)
                }
            }
        }
    }
}
//
//#Preview {
//    SettingsView(settingsViewModel: <#SettingsViewModel#>)
//}
