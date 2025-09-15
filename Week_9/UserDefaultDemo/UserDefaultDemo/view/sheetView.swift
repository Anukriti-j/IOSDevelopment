import SwiftUI

struct sheetView: View {
    @ObservedObject var viewModel: ViewModel
    @State var name: String = ""
    @State var age: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        TextField("enter student name", text: $name)
            .padding()
            .textFieldStyle(.roundedBorder)
        TextField("enter student age", text: $age)
            .padding()
            .textFieldStyle(.roundedBorder)
        Button("Done") {
            viewModel.addStudents(name: name, age: Int(age) ?? 0)
            dismiss()
            name = ""
            age = ""
        }
        .padding()
        .background(Color.yellow)
        .cornerRadius(8)
        
    }
}

#Preview {
    sheetView(viewModel: ViewModel())
}
