import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = TaskViewModel()
    @State var newTask = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add a new task", text: $newTask)
                        .textFieldStyle(.roundedBorder)
                    Button("Add") {
                        if !newTask.isEmpty {
                            viewModel.addTask(newTask: newTask)
                            newTask = ""
                        }
                    }
                }
                .padding()
                List {
                    ForEach(viewModel.tasks) { task in
                        taskRowView(viewModel: viewModel, task: task)
                    }
                }
                NavigationLink("View by status") {
                    FilteredListView(viewModel: viewModel)
                }
                .padding()
            }
        }
        .navigationTitle("View Tasks")
    }
}

#Preview {
    HomeView()
}
