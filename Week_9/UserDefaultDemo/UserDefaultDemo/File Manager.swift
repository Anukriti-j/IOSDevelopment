import Foundation

func createNewDirectory() {
    let fileManager = FileManager.default
    let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let newDirURL = documentURL.appendingPathComponent("MyNewFolder")
    if !fileManager.fileExists(atPath: newDirURL.path) {
        do {
            try fileManager.createDirectory(at: newDirURL, withIntermediateDirectories: true, attributes: nil) // creating new directory
//            let fileURL  = newDirURL.appendingPathComponent("welcome.txt") // creating files
//            let content = "welcome anukriti to file manager"
//            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            print("directory created at : \(newDirURL.path)")
        } catch {
            print("error creating directory")
        }
    }
    let data = "hello ANukriti".data(using: .utf8)
    let fileURL = newDirURL.appendingPathComponent("anukriti.txt")
    let success = fileManager.createFile(atPath: fileURL.path, contents: data)
    if success {
        print("file create at  \(fileURL)")
    } else {
        print("error in file creation")
    }
}

func deleteFile() {
    let filePath = URL(fileURLWithPath: "/Users/coditas/Library/Developer/CoreSimulator/Devices/955563FA-D6DE-484D-B9A4-615467B61B17/data/Containers/Data/Application/9E42B96B-4372-4A59-87A4-252FDFE55836/Documents/MyNewFolder/anukriti.txt")
    if FileManager.default.fileExists(atPath: filePath.path) {
        do {
            try FileManager.default.removeItem(at: filePath)
        } catch {
            print("cannot remove item")
        }
    }
}

func fileExist() {
    let filePath = URL(fileURLWithPath: "/Users/coditas/Library/Developer/CoreSimulator/Devices/955563FA-D6DE-484D-B9A4-615467B61B17/data/Containers/Data/Application/9E42B96B-4372-4A59-87A4-252FDFE55836/Documents/MyNewFolder/anukriti.txt")
    if FileManager.default.fileExists(atPath: filePath.path) {
        print("file exists")
    } else {
        print("file is deleted")
    }
}

func copyFile() {
    let fileManager = FileManager.default
    let sourceURL = URL(fileURLWithPath: "/Users/coditas/Library/Developer/CoreSimulator/Devices/955563FA-D6DE-484D-B9A4-615467B61B17/data/Containers/Data/Application/9E42B96B-4372-4A59-87A4-252FDFE55836/Documents/MyNewFolder/anukriti.txt")
    let destinationURL = URL(fileURLWithPath: "/Users/coditas/Library/Developer/CoreSimulator/Devices/955563FA-D6DE-484D-B9A4-615467B61B17/data/Containers/Data/Application/9E42B96B-4372-4A59-87A4-252FDFE55836/Documents/MyNewFolder")
    do {
        if !fileManager.fileExists(atPath: destinationURL.path) {
            try fileManager.createDirectory(at: destinationURL, withIntermediateDirectories: true)
        }
        try fileManager.copyItem(at: sourceURL, to: destinationURL)
        //MARK: moving multiple files from a directory
     //   try fileManager.moveItem(at: sourceURL, to: destinationURL)  moving items
//        let files = try fileManager.contentsOfDirectory(at: sourceURL, includingPropertiesForKeys: nil)
//        for fileURL in files {
//            let destinationUrl = destinationURL.appendingPathComponent(fileURL.lastPathComponent)
//            try fileManager.moveItem(at: sourceURL, to: destinationURL)
//        }
        print("Item copied successfully")
    } catch {
        print("cannot copy item: \(error.localizedDescription)")
    }
}

func getDocumentDirectory() -> URL? {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
}
//saving text files
func saveText(text: String, to fileName: String) {
    let fileURL = getDocumentDirectory()?.appendingPathComponent(fileName)
    do {
        try text.write(to: fileURL!, atomically: true, encoding: .utf8)
        print("written file at \(fileURL?.path())")
    } catch {
        print("cannot save text to file")
    }
}

func loadText(from fileName: String) -> String? {
    let fileURL = getDocumentDirectory()?.appendingPathComponent(fileName)
    do {
        return try String(contentsOf: fileURL!, encoding: .utf8)
    } catch {
        print("cant read from file")
        return nil
    }
}
//saving and loading json
struct Person: Codable {
    let name: String
    let age: Int
}
func saveJSON<T: Codable>(_ object: T, to fileName: String) {
    let fileURL = getDocumentDirectory()?.appendingPathComponent(fileName)
    do {
        let encodedData = try JSONEncoder().encode(object)
        try encodedData.write(to: fileURL!)
        print("file written at \(fileURL?.path())")
    } catch {
        print("failed to save JSON \(error)")
    }
}

func loadJson(from fileName: String) -> Person? {
    let fileURL = getDocumentDirectory()?.appendingPathComponent(fileName)
    do {
        let JSONData = try Data(contentsOf: fileURL!)
        let decodedData = try JSONDecoder().decode(Person.self, from: JSONData)
        return decodedData
    }
    catch {
        print("Failed to read json file")
        return nil
    }
}
