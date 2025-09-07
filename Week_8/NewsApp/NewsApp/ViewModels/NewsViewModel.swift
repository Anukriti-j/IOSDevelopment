import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isInitialLoading: Bool = false
    @Published var errorMessage: String?
    
    func getHeadlines(isInitialLoad: Bool = false) async {
        if isInitialLoad {
            isInitialLoading = true
        }
        defer {
            isInitialLoading = false
        }
        errorMessage = nil
        do {
            articles = try await NewsAPIService.fetchHeadlines()
        } catch {
            errorMessage = error.localizedDescription
        }    
    }
}
