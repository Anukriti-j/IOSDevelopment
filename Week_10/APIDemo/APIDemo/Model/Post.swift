

import Foundation

struct Post: Decodable, Identifiable {
    let id, userId: Int
    let title, body: String
    
    enum codingkeys: String, CodingKey {
        case userID = "UserId"
        case id, title, body
    }
}
