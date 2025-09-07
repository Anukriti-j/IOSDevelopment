import Foundation

struct Article: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let content: String?
    let publishedAt: Date
    let author: String?
}

