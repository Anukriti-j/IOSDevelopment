
import SwiftUI

struct AddView: View {
    @State var newName: String = ""
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
     
    var body: some View {
        VStack {
            Text("Add user name")
            TextField("add user", text: $newName)
            Button("Done") {
                viewModel.addUser(name: newName)
                dismiss()
            }
        }
    }
}
//
//#Preview {
//    AddView()
//}
