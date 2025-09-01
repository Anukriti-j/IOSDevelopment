import SwiftUI

struct TaskListRowView: View {
    @ObservedObject var taskViewModel: TaskViewModel
    var task: TaskEntity
    
    var body: some View {
        NavigationLink(destination: TaskDetailView(taskViewModel: taskViewModel, selectedTask: task), label: {
            Image("Task")
                .resizable()
                .foregroundColor(Color.blue)
                .frame(width: 20, height: 20)
            Text(task.title ?? "No title")
                .font(.headline)
                .foregroundColor(.primary)
                .padding()
        })
    }
}
//
//#Preview {
//    TaskListRowView()
//}
//
