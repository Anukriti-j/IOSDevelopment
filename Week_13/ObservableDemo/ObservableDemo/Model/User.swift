import Foundation

@Observable
class User {
    let name: String
    let age: Int
    var followerCount: Int
    
    init(name: String, age: Int, followerCount: Int) {
        self.name = name
        self.age = age
        self.followerCount = followerCount
    }
}


