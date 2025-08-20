import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    
    func addTask(newTask: String) {
        let task = TaskModel(title: newTask, isCompleted: false)
        tasks.append(task)
    }
    
    func toggleTask( _ task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    var completedTasks: [TaskModel] {
        tasks.filter { $0.isCompleted }
    }
    
    var incompleteTasks: [TaskModel] {
        tasks.filter { !$0.isCompleted }
    }
    
}
