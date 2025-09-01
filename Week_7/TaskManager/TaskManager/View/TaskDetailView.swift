import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var taskViewModel: TaskViewModel
    var selectedTask: TaskEntity
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Toggle(isOn: $taskViewModel.isCompleted) {
                    Text("Mark as Completed")
                        .font(.headline)
                }
                .onChange(of: taskViewModel.isCompleted) { oldValue, newValue in
                    taskViewModel.updateCompletion(for: selectedTask, to: newValue)
                }
                
                Text("Title")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Text(selectedTask.title ?? "Not found")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                if let detail = selectedTask.taskDetail, !detail.isEmpty {
                    Text("Description")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Text(detail)
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 20)
        }
        .onAppear {
            taskViewModel.isCompleted = selectedTask.isCompleted
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
