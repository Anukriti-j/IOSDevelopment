import SwiftUI
import CoreLocation

struct ImageDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let photo: Photo
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            ZoomableImageView(image: photo.image)
            
            CityInfoView(cityName: photo.metadata.cityName)
            
            CoordinatesView(latitude: photo.metadata.latitude, longitude: photo.metadata.longitude)
            
            AddedDateView(date: photo.metadata.timestamp)
            
            Spacer()
            
            CloseButton {
                dismiss()
            }
        }
        .padding()
        .background(Color.black.opacity(0.9))
    }
}

private struct CityInfoView: View {
    let cityName: String?
    
    var body: some View {
        Group {
            if let city = cityName {
                Text("City: \(city)")
                    .font(.subheadline)
            } else {
                Text("Fetching city name...")
                    .foregroundColor(.gray)
            }
        }
    }
}

private struct CoordinatesView: View {
    let latitude: Double?
    let longitude: Double?
    
    var body: some View {
        Group {
            if let latitude = latitude, let longitude = longitude {
                VStack(spacing: 2) {
                    Text("Lat: \(latitude)")
                    Text("Lon: \(longitude)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            } else {
                Text("Getting location...")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

private struct AddedDateView: View {
    let date: Date
    
    var body: some View {
        Text("Added: \(formattedDate)")
            .font(.footnote)
            .foregroundColor(.white.opacity(0.8))
            .padding(.top, 4)
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

private struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button("Close", action: action)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.2))
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
