import SwiftUI

@main
struct DiaryApp: App {
    @StateObject var settingsViewModel = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(settingsViewModel)
                .preferredColorScheme(settingsViewModel.colorScheme)
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}

//add duplicate logic
//delete from list
//filter list
//drag and drop in list
//code review
//deleting from core data also

