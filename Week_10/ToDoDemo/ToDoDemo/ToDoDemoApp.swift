
import SwiftUI

@main
struct ToDoDemoApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var settingsViewModel: SettingsViewModel = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(settingsViewModel)
                .preferredColorScheme(settingsViewModel.colorScheme)
        }
    }
}
