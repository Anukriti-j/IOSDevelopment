import Foundation
import UIKit

class FileManagerService {
    static let shared = FileManagerService()
    private init() {}
    
    private let metaDataFile = "metadata.json"
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func saveImage(_ image: UIImage, id: UUID) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let fileName = "\(id.uuidString).jpg"
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            try data.write(to: url)
            return fileName
        } catch {
            print("Error saving image:", error)
            return nil
        }
    }
    
    func loadImage(fileName: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        return UIImage(contentsOfFile: url.path)
    }
    
    func saveMetadata(_ metadata: [ImageMetadata]) {
        let url = getDocumentsDirectory().appendingPathComponent(metaDataFile)
        do {
            let data = try JSONEncoder().encode(metadata)
            try data.write(to: url)
        } catch {
            print("Failed to save metadata:", error)
        }
    }
    
    func loadMetadata() -> [ImageMetadata] {
        let url = getDocumentsDirectory().appendingPathComponent(metaDataFile)
        guard let data = try? Data(contentsOf: url) else { return [] }
        return (try? JSONDecoder().decode([ImageMetadata].self, from: data)) ?? []
    }
    
    func deleteMetadata(_ photo: Photo) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(photo.metadata.filename)
        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch {
            print("Error deleting file: \(error)")
        }
    }
}
