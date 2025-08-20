import SwiftUI

struct taskRowView: View {
    @ObservedObject var viewModel: TaskViewModel
    var task: TaskModel
    
    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            Toggle("", isOn: Binding(
                get: { task.isCompleted }, set: { _ in
                    viewModel.toggleTask(task)
                }
            ))
            .labelsHidden()
        }
    }
}
