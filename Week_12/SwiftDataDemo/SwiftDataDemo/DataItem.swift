import Foundation
import SwiftData

@Model
class DataItem {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
