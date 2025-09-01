import SwiftUI

struct AddTaskSheetView: View {
    @ObservedObject var taskViewModel: TaskViewModel
    @State var newtitle: String = ""
    @State var taskDetail: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            TextField("Title", text: $newtitle)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                .padding(.horizontal)
                .padding(.top, 30)
            
            ZStack(alignment: .topLeading) {
                // Placeholder text
                if taskDetail.isEmpty {
                    Text("Enter description here...")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 12)
                        .padding(.top, 16)
                }
                TextEditor(text: $taskDetail)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
            }
            .frame(height: 150)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
            .padding(.horizontal)
            
            Button {
                taskViewModel.addData(newtitle: newtitle, detail: taskDetail)
                newtitle = ""
                taskDetail = ""
                dismiss()
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            Spacer()
        }
        .alert(isPresented: $taskViewModel.showAlert) {
            Alert(title: Text("Alert"), message: Text("\(taskViewModel.alertMsg)"), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    AddTaskSheetView(taskViewModel: TaskViewModel())
}
