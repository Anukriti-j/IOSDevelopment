import Foundation

final class StudentStorage {
    static let shared = StudentStorage()
    
    private var fileURL: URL
    
    private init(fileName: String = "Student.json") {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        self.fileURL = documentURL!.appendingPathComponent(fileName)
    }
    
    func saveToStore(data: [StudentModel]) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: fileURL)
            try FileManager.default.setAttributes([.protectionKey: FileProtectionType.complete] , ofItemAtPath: fileURL.path())
            print("data saved successfully")
        } catch {
            print("cannot save data: \(error)")
        }
    }
    
    struct Storage: Codable {
        let studentList: [StudentModel]
    }
    
    func loadFromStore() -> [StudentModel]? {
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            do {
                let jsonData = try Data(contentsOf: fileURL)
                let decodedData = try JSONDecoder().decode([StudentModel].self, from: jsonData)
                print("data load successfully")
                return decodedData
            } catch {
                print("cannot decode data from store: \(error)")
                return nil
            }
        }
        return []
    }
}
