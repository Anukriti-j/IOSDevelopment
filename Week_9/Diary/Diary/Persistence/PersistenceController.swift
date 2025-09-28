import Foundation
import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    let container: NSPersistentContainer
    private init() {
        self.container = NSPersistentContainer(name: "Note")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core data failed to laod: \(error.localizedDescription)")
            } else {
                print("Core data successfully loaded")
            }
        }
    }
}
