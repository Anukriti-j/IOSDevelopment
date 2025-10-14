import CoreLocation

protocol LocationService {
    var location: CLLocation? { get }
    func requestAuthorization()
}
