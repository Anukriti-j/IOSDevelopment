import SwiftUI

struct EditListView: View {
    @ObservedObject var viewModel: StudentViewModel
    @State var name: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("Edit list")
        TextField("Edit Name", text: $name)
            .padding()
        Button {
            viewModel.saveData(name: name)
            dismiss()
        } label: {
            Text("OK")
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(8)
        }
    }
}

#Preview {
    EditListView(viewModel: StudentViewModel())
}
