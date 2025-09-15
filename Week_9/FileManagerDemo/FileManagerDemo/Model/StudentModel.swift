import Foundation

struct StudentModel: Codable, Identifiable {
    let id = UUID()
    let name: String
}
