import Foundation
import CoreData

class TaskViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var taskList: [TaskEntity] = []
    @Published var alertMsg: String = ""
    @Published var showAlert: Bool = false
    @Published var isCompleted: Bool = false
    @Published var completedCount: Int = 0
    @Published var pendingCount: Int = 0
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        do {
            taskList = try viewContext.fetch(request)
            updateCounts()
        } catch {
            print("error in fetching data")
        }
    }
    
    func addData(newtitle: String, detail: String) {
        guard !newtitle.isEmpty else {
            showAlert = true
            return alertMsg = "Cannot Leave title empty"
        }
        for index in taskList.indices {
            if (taskList[index].title?.lowercased() == newtitle.lowercased()) {
                showAlert = true
                alertMsg = "Task exists"
                return
            }
        }
        let task = TaskEntity(context: viewContext)
        task.id = UUID()
        task.title = newtitle
        task.taskDetail = detail
        self.fetchData()
        showAlert = true
        alertMsg = "Success"
    }
    
    func deleteData(task: TaskEntity) {
        viewContext.delete(task)
        save()
        fetchData()
    }
    
    func filterData(searchText: String) -> [TaskEntity] {
        guard !searchText.isEmpty else { return taskList }
        return taskList.filter { $0.title?.localizedCaseInsensitiveContains(searchText) ?? false }
    }
    
    func updateCompletion(for task: TaskEntity, to isCompleted: Bool) {
        task.isCompleted = isCompleted
        save()
        fetchData()
    }
    
    func updateCounts() {
        completedCount = taskList.filter { $0.isCompleted == true }.count
        pendingCount = taskList.filter { $0.isCompleted == false }.count
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("error in saving")
        }
    }
}
