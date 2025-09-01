import SwiftUI

struct HomeView: View {
    @StateObject var taskViewModel = TaskViewModel()
    @State var newTask: String = ""
    @State var searchText: String = ""
    @State var sheetPresented = false
    
    var body: some View {
        NavigationStack {
            Spacer()
            HStack {
                CountCardView(status: "Completed", count: taskViewModel.completedCount)
                CountCardView(status: "Pending", count: taskViewModel.pendingCount)
            }
            ZStack {
                VStack {
                    List {
                        let filteredList = taskViewModel.filterData(searchText: searchText)
                        ForEach(filteredList) {task in
                            TaskListRowView(taskViewModel: taskViewModel, task: task)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let taskToDelete = filteredList[index]
                                taskViewModel.deleteData(task: taskToDelete)
                            }
                        }
                    }
                    .listRowSpacing(16)
                    Spacer()
                }
                VStack {
                    Spacer()
                    Button {
                        sheetPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 8)
                            .padding(.bottom, 16)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search Task")
        .sheet(isPresented: $sheetPresented, content: {
            AddTaskSheetView(taskViewModel: taskViewModel)
                .presentationDetents([.medium, .large])
        })
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    HomeView()
}

struct CountCardView: View {
    var status: String
    var count: Int
    var body: some View {
        VStack {
            Text("\(count)")
                .padding([.top, .horizontal])
                .font(Font.system(size: 30))
                .font(.headline)
                .fontWeight(.bold)
            Text("\(status)")
                .font(.headline)
                .fontWeight(.bold)
                .padding([.bottom, .horizontal])
        }
        .padding()
        .frame(width: 160, height: 150)
        .background(Color.blue.opacity(0.8))
        .foregroundColor(Color.white)
        .cornerRadius(8)
        .shadow(radius: 8)
        .padding()
    }
}
