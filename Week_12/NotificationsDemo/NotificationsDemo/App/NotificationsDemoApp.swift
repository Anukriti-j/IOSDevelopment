import SwiftUI

@main
struct NotificationsDemoApp: App {
    
    var body: some Scene {
        WindowGroup {
            GalleryView()
                .onAppear {
                    Task {
                        await LocalNotificationManager.manager.requestAuthorization()
                        LocationManager.shared.requestAuthorization()
                    }
                }
        }
    }
}
