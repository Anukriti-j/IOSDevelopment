
import Foundation
import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    private init() {
        self.container = NSPersistentContainer(name: "User")
        container.loadPersistentStores { _ , error in
            if let error = error {
                print("error in loading core data: \(error)")
            } else {
                print("core data success loaded") 
            }
        }
    }
}
