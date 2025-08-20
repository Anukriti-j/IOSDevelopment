import Foundation

struct TaskModel: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}
