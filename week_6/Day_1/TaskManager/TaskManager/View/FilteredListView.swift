import SwiftUI

struct FilteredListView: View {
    @ObservedObject var viewModel: TaskViewModel
    var body: some View {
        TabView {
            TaskListView(viewModel: viewModel, tasks: viewModel.incompleteTasks, title: "incomplete" )
                .tabItem {
                    Label("Incomplete", systemImage: "circle")
                }
            TaskListView(viewModel: viewModel, tasks: viewModel.completedTasks, title: "Complete" )
                .tabItem {
                    Label("Completed", systemImage: "checkmark.circle")
                }
        }
    }
}
