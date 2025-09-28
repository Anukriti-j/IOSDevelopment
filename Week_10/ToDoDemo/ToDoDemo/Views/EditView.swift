import SwiftUI
import CoreData

struct EditView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var editname: String = ""
    @ObservedObject var user: User
    
    init(viewModel: ViewModel, user: User) {
        self.viewModel = viewModel
        self.user = user
    }
    
    var body: some View {
        NavigationStack {
            
            TextField("Edit name", text: $editname)
            Button("save") {
                user.name = editname
                viewModel.save()
            }
            .onAppear(perform: {
                editname = user.name ?? ""
            })
            .navigationTitle("Edit Username")
        }
    }
}

//#Preview {
//    EditView(name: .constant("Vivek"), desciption: .constant("Hello Vivek"))
//}
