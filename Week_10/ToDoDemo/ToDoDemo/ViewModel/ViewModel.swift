
import Foundation
import SwiftUICore
import CoreData

class ViewModel: ObservableObject {
    private var context: NSManagedObjectContext
    @Published var userList: [User] = []
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addUser(name: String) {
        let newUser = User(context: context)
        newUser.id = UUID()
        newUser.name = name
        save()
    }
    
    func deleteUser(_ user: User) {
        context.delete(user)
        save()
    }
    
    func save() {
        do {
            try context.save()
            print("core data saved successfully")
        } catch {
            print("error in saving data : \(error)")
        }
    }
}
