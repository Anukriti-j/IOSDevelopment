import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel: TaskViewModel
    var tasks: [TaskModel]
    var title: String
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                taskRowView(viewModel: viewModel, task: task)
            }
        }
        .navigationTitle(title)
    }
}
