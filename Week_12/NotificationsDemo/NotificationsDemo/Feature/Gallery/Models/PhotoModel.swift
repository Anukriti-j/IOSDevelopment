import UIKit
import CoreLocation

struct Photo: Identifiable, Equatable {
    let id: UUID
    let image: UIImage
    let metadata: ImageMetadata
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ImageMetadata: Identifiable, Codable {
    let id: UUID
    let filename: String
    let latitude: Double?
    let longitude: Double?
    let cityName: String?
    let timestamp: Date
    
    init(
        id: UUID = UUID(),
        filename: String,
        latitude: Double?,
        longitude: Double?,
        cityName: String? = nil,
        timestamp: Date = Date(),
    ) {
        self.id = id
        self.filename = filename
        self.latitude = latitude
        self.longitude = longitude
        self.cityName = cityName
        self.timestamp = timestamp
    }
}


