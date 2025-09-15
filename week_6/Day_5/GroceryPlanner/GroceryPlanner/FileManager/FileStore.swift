import Foundation
import SwiftUICore

class FileStore {
    @ObservedObject private var viewModel: GroceryViewModel
    private let fileURL: URL
    
    init(fileName: String = "Data.json") {
        let document = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = document.appendingPathComponent(fileName)
        loadFile()
    }
    
    private struct Storage: Codable {
        var category: String
        var categoryItem: [GroceryItemModel]
    }
    
    func saveFile(category: String, categoryItem: GroceryItemModel) {
        let storage = Storage(category: , categoryItem: <#T##[GroceryItemModel]#>)
    }
    
    func loadFile() {
        
    }
}
//let fileManager = FileManager.default
//
//func getDocumentDirectory() -> URL? {
//    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//}
//
//func appendToFile<T: Codable>(model object: T, to fileName: String) {
//    let fileURL = getDocumentDirectory()?.appendingPathComponent(fileName)
//    if !fileManager.fileExists(atPath: fileURL!.path()) {
//        do {
//            let encodedData = try JSONEncoder().encode(object)
//            try encodedData.write(to: fileURL!)
//            print("file created and data written")
//        } catch {
//            print("error creating file: \(error)")
//        }
//        return
//    }
//    do {
//        let fileHandle = try FileHandle(forWritingTo: fileURL!)
//        fileHandle.seekToEndOfFile()
//        let encodedData = try JSONEncoder().encode(object)
//        fileHandle.write(encodedData)
//        fileHandle.closeFile()
//    } catch {
//        print("\(error.localizedDescription)")
//    }
//    
//}
//
//func loadJSON(from fileName: String) -> [GroceryCategoryModel]? {
//    let fileURL = getDocumentDirectory()?.appendingPathComponent(fileName)
//    do {
//        let JSONData = try Data(contentsOf: fileURL!)
//        let decodedData = try JSONDecoder().decode([GroceryCategoryModel].self, from: JSONData)
//        return decodedData
//    } catch {
//        print("cannot decode data from json to text: \(error)")
//        return nil
//    }
//}
