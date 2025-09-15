
import Foundation

class ViewModel: ObservableObject {
    @Published var studentList: [Student] = []
    
    var isValid: Bool = true
    init() {
        loadData()
        //        createNewDirectory()
        //        deleteFile()
        //        fileExist()
        //        copyFile()
        //        saveText(text: "Hello ANukriti writing file", to: "ios.txt")
        //        if let loadedText = loadText(from: "ios.txt") {
        //            print("loaded text: \(loadedText)")
        //        }
        saveJSON(Person(name: "Tushar", age: 21), to: "Person.json")
        if let person = loadJson(from: "Person.json") {
            print("name: \(person.name), age: \(person.age)")
        }
    }
    
    func loadData() {
        if let cachedData = getCachedData() {
            self.studentList = cachedData
        } else {
            studentList = []
        }
    }
    
    func addStudents(name: String, age: Int) {
        let valid = validateData(name, age)
        if valid{
            let student = Student(name: name, age: age)
            studentList.append(student)
        }
        saveCacheData()
    }
    
    func validateData(_ name: String, _ age: Int) -> Bool {
        if !name.isEmpty && !String(age).isEmpty {
            isValid = true
        } else {
            isValid = false
        }
        return isValid
    }
    
    func getCachedData() -> [Student]? {
        if let data = UserDefaults.standard.data(forKey: "Student"){
            if let decodedData = try? JSONDecoder().decode([Student].self, from: data) {
                return decodedData
            }
        }
        return nil
    }
    
    func saveCacheData() {
        if let encodedData = try? JSONEncoder().encode(studentList) {
            let savedData = UserDefaults.standard.set(encodedData, forKey: "Student")
        }
    }
    
    func deleteRow(at offset: IndexSet) {
        studentList.remove(atOffsets: offset)
        saveCacheData()
    }
}
