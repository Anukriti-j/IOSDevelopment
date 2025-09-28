import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject private var viewModel: UserViewModel = UserViewModel()
    
//    init(context: NSManagedObjectContext) {
//        _viewModel = StateObject(wrappedValue: UserViewModel(context: context))
//    }
    
    var body: some View {
        NavigationStack {
            if viewModel.initialLoading {
                ProgressView("Loading...")
            } else {
                List {
                    ForEach(viewModel.users) { user in
                        NavigationLink {
                            PostView(id: user.id)
                        } label: {
                            Text(user.name ?? "Unknown")
                        }
                    }
                }
                .navigationTitle("News")
                .refreshable {
                    await viewModel.fetchUsers(loading: true)
                    viewModel.saveToCore(context: context)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchUsers(loading: true)
                viewModel.saveToCore(context: context)
            }
        }
        
    }
}
//
//#Preview {
//    ContentView()
//}
