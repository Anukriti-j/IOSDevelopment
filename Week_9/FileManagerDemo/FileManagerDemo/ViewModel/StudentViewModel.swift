import Foundation

class StudentViewModel: ObservableObject {
    @Published var studentList: [StudentModel] = StudentStorage.shared.loadFromStore() ?? []
    
    func saveData(name: String) {
        studentList.append(StudentModel(name: name))
        StudentStorage.shared.saveToStore(data: studentList)
    }
}
