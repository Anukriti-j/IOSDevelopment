import SwiftUI
import CoreData

struct ListView: View {
    @StateObject private var viewModel: ViewModel
    private var context: NSManagedObjectContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)], animation: .default)
    private var users: FetchedResults<User>
    
    init(context: NSManagedObjectContext) {
        self.context = context
        _viewModel = StateObject(wrappedValue: ViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        EditView(viewModel: viewModel, user: user)
                    } label: {
                        Text(user.name ?? "Unknown")
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let deleteUser = users[index]
                        viewModel.deleteUser(deleteUser)
                    }
                }
            }
            NavigationLink {
                AddView(viewModel: viewModel)
            } label: {
                Text("ADD")
                    .font(.headline)
                    .padding()
            }

        }
        .navigationTitle("List of names")
    }
        
}

//
//#Preview {
//    ListView()
//}

