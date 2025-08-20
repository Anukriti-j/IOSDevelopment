import SwiftUI

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
