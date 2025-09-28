import Foundation
import CoreData

//MARK:- ERRor handling
class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    private init() {
        self.container = NSPersistentContainer(name: "User")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core data failed to laod: \(error.localizedDescription)")
            } else {
                print("Core data successfully loaded")
            }
        }
    }
}


