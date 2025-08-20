import SwiftUI

struct AddTaskView: View {
    
    @StateObject private var tasks = TaskClass()
    @State var newTask = ""
    
    var body: some View {
        VStack {
            
            TextField("Add new task", text: $newTask)
                .padding()
                .textFieldStyle(.roundedBorder)
            //                .border(Color.gray, width: 1)
                .cornerRadius(5)
                .frame(height: 40, alignment: .center)
                .padding()
            Button("ADD") {
                guard !newTask.isEmpty else { return }
                tasks.taskList.append(Task(title: newTask))
                newTask = ""
            }
            .padding()
            .background(Color.yellow)
            .foregroundColor(.black)
            .cornerRadius(5)
            NavigationLink("Show List") {
                ListTaskView(tasks: tasks)
            }
            .navigationTitle("List of tasks")
            .foregroundColor(.blue)
            .padding()
        }
        .padding()
        .frame(alignment: .center)
    }
}

struct ListTaskView: View {
    
    @ObservedObject var tasks: TaskClass
    
    var body: some View {
        List {
            ForEach($tasks.taskList) { $item in
                HStack {
                    Text(item.title)
                    Spacer()
                    Toggle("", isOn: $item.isCompleted)
                        .labelsHidden()
                        .onChange(of: item.isCompleted) { newValue in
                            if newValue {
                                tasks.completeCount += 1
                            } else {
                                tasks.completeCount -= 1
                            }
                        }
                }
            }
        }
        Text("Completed Tasks: \(tasks.completeCount)")
    }
}

#Preview {
    AddTaskView()
}
