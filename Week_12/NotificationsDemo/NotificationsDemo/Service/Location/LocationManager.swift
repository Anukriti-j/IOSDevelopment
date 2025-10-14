import Foundation
import CoreLocation
import SwiftUI

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var cityName: String? = nil
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("Waiting for permission")
        case .restricted, .denied:
            print("Location access denied")
            openSettings()
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location authorized, starting updates")
            manager.startUpdatingLocation()
        @unknown default:
            print("Unknown authorization status")
        }
    }
    
    private func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @MainActor
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else { return }
        location = latestLocation
        reverseGeocode(location: latestLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed with error: \(error.localizedDescription)")
    }
    
    @MainActor
    private func reverseGeocode(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                print("Reverse geocode failed: \(error.localizedDescription)")
                self?.cityName = "Unknown"
                return
            }
            
            guard let placeMark = placemarks?.first else {
                print("No placemarks found")
                self?.cityName = "Unknown"
                return
            }
            
            if let city = placeMark.locality {
                self?.cityName = city
            } else if let subAdminArea = placeMark.subAdministrativeArea {
                self?.cityName = subAdminArea
            } else if let adminArea = placeMark.administrativeArea {
                self?.cityName = adminArea
            } else {
                print("No city info found in placemark")
                self?.cityName = "Unknown"
            }
        }
    }
}
