import Foundation

class TaskClass: ObservableObject {
    @Published var taskList: [Task] = []
    @Published var completeCount = 0
}

struct Task: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}
