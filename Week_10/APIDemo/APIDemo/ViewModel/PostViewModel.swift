import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var initialLoading: Bool = true
    let baseUrl = "https://jsonplaceholder.typicode.com/posts"
    
    @MainActor
    func fetchPosts(userId: Int) async {
        defer {
            initialLoading = false
        }
        do {
            posts = try await NewsAPIService.service.getData(from: baseUrl, with: ["userID": "\(userId)"])
        } catch {
            print("\(error)")
        }
    }
}
