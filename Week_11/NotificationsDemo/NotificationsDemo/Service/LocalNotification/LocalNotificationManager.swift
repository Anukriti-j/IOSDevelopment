import Foundation
import NotificationCenter
import SwiftUI

@MainActor
final class LocalNotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let manager = LocalNotificationManager()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    @Published var isGranted: Bool = false
    //    @Published var pendingRequests: [UNNotificationRequest] = []
    
    override init() {
        super.init()
        notificationCenter.delegate =  self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .banner]
    }
    
    func requestAuthorization() async {
        do {
            try await notificationCenter.requestAuthorization(options: [.badge, .sound, .alert])
            await getCurrentSettings()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func getCurrentSettings() async {
        let currentSettings = await notificationCenter.notificationSettings()
        isGranted = (currentSettings.authorizationStatus == .authorized)
        print(isGranted)
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                
            }
        }
    }
    
    func scheduleBatchNotification(for items: [ImageMetadata]) {
        guard !items.isEmpty else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Photo Added"
        
        if let city = items.first?.cityName {
            content.body = "\(items.count) photo(s) added at \(city)."
        } else {
            content.body = "\(items.count) photo(s) added."
        }
        content.sound = .default
        print(content.title)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    //    func getPendingRequest() async {
    //        pendingRequests = await notificationCenter.pendingNotificationRequests()
    //    }
    //
    //    func removeRequests(withIdentifier identifier: String) {
    //        notificationCenter.removeDeliveredNotifications(withIdentifiers: [identifier])
    //        if let index = pendingRequests.firstIndex(where: { $0.identifier == identifier}) {
    //            pendingRequests.remove(at: index)
    //        }
    //    }
    //
    //    func clearRequests() {
    //        notificationCenter.removeAllPendingNotificationRequests()
    //        pendingRequests.removeAll()
    //    }
}
