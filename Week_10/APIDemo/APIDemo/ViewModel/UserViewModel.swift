import Foundation
import CoreData

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    @Published var initialLoading: Bool = true
    let baseURL = "https://jsonplaceholder.typicode.com/users"
   /* private var context: NSManagedObjectCont*/

    
    func fetchUsers(loading: Bool) async {
        defer {
            initialLoading = false
        }
        do {
            users = try await NewsAPIService.service.getData(from: baseURL)
        } catch {
            print("error: \(error)")
        }
    }
    
    func saveToCore(context: NSManagedObjectContext) {
        _ = User(context: context)
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
    }
}
