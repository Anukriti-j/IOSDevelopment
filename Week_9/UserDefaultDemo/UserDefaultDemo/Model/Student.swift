import Foundation

struct Student: Identifiable, Codable {
    let id = UUID()
    let name: String?
    let age: Int?
}
