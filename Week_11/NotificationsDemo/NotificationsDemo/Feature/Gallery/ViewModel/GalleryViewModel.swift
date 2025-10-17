import Foundation
import SwiftUI
import PhotosUI
import CoreLocation

@MainActor
class GalleryViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var isFetchingLocation = false
    @Published var selectedImageForDetail: Photo? = nil
    @Published var isSelectionMode: Bool = false
    @Published var selectedPhotos: Set<UUID> = []
    
    private var locationManager = LocationManager()
    
    init() {
        loadSavedImages()
    }
    
    func loadSavedImages() {
        let savedMetadata = FileManagerService.shared.loadMetadata()
        var loadedPhotos: [Photo] = []
        for meta in savedMetadata {
            if let img = FileManagerService.shared.loadImage(fileName: meta.filename) {
                loadedPhotos.append(Photo(id: meta.id, image: img, metadata: meta))
            }
        }
        photos = loadedPhotos
    }
    
    func saveImageToFileAndReturnMeta(_ uiImage: UIImage) async -> ImageMetadata? {
        isFetchingLocation = true
        
        let (latitude, longitude, city) = await waitForLocation(timeout: 5)
        let id = UUID()
        
        guard let filename = FileManagerService.shared.saveImage(uiImage, id: id) else {
            isFetchingLocation = false
            return nil
        }
        
        let meta = ImageMetadata(
            id: id,
            filename: filename,
            latitude: latitude,
            longitude: longitude,
            cityName: city,
            timestamp: Date()
        )
        
        var existingMetadata = FileManagerService.shared.loadMetadata()
        existingMetadata.append(meta)
        FileManagerService.shared.saveMetadata(existingMetadata)
        photos.append(Photo(id: id, image: uiImage, metadata: meta))
        
        isFetchingLocation = false
        return meta
    }
    
    func waitForLocation(timeout: TimeInterval) async -> (Double?, Double?, String?) {
        let start = Date()
        var latitude = locationManager.location?.coordinate.latitude
        var longitude = locationManager.location?.coordinate.longitude
        var city = locationManager.cityName
        
        while (latitude == nil || longitude == nil || city == nil), Date().timeIntervalSince(start) < timeout {
            try? await Task.sleep(nanoseconds: 200_000_000) // 0.2 sec
            
            latitude = locationManager.location?.coordinate.latitude
            longitude = locationManager.location?.coordinate.longitude
            city = locationManager.cityName
        }
        
        return (latitude, longitude, city)
    }
    
    func handlePhotoSelection(items: [PhotosPickerItem]) async {
        var notificationMetaData: [ImageMetadata] = []
        for item in items {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data),
               let resizedImage = uiImage.resize(to: CGSize(width: 300, height: 300)) {
                if let meta = await saveImageToFileAndReturnMeta(resizedImage) {
                    notificationMetaData.append(meta)
                }
            }
        }
        if !notificationMetaData.isEmpty {
            LocalNotificationManager.manager.scheduleBatchNotification(for: notificationMetaData)
        }
    }

    func deletePhoto(_ photo: Photo) {
        DispatchQueue.global(qos: .background).async {
            FileManagerService.shared.deleteMetadata(photo)
        }
        var metadata = FileManagerService.shared.loadMetadata()
        metadata.removeAll { $0.id == photo.id }
        FileManagerService.shared.saveMetadata(metadata)
        photos.removeAll { $0.id == photo.id }
    }
    
    
    func selectImageForDetail(_ photo: Photo) {
        selectedImageForDetail = photo
    }
    
    func dismissImageDetail() {
        selectedImageForDetail = nil
    }
}

extension GalleryViewModel {
    func deletePhotos(withIDs ids: [UUID]) {
        photos.removeAll { photo in
            ids.contains(photo.id)
        }
        var existingMetadata = FileManagerService.shared.loadMetadata()
        existingMetadata.removeAll { meta in
            ids.contains(meta.id)
        }
        FileManagerService.shared.saveMetadata(existingMetadata)
        for id in ids {
            let fileName = "\(id).jpg"
            let url = FileManagerService.shared.getDocumentsDirectory().appendingPathComponent(fileName)
            try? FileManager.default.removeItem(at: url)
        }
    }
    
    func toggleSelection(for photo: Photo) {
        if selectedPhotos.contains(photo.id) {
            selectedPhotos.remove(photo.id)
        } else {
            selectedPhotos.insert(photo.id)
        }
    }
    
    func clearSelection() {
        selectedPhotos.removeAll()
        isSelectionMode = false
    }
}
