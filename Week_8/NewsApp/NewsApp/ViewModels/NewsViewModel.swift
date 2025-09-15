import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isInitialLoading: Bool = false
    @Published var errorMessage: String?
    var saveItemKey: String = "item_list"
    
    init() {
        loadArticles()
    }
    
    func fetchArticlesFromAPI(isInitialLoad: Bool = false) async {
        if isInitialLoad {
            isInitialLoading = true
        }
        defer {
            isInitialLoading = false
        }
        errorMessage = nil
        do {
            articles = try await NewsAPIService.fetchHeadlines()
            saveArticles(articles)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func loadArticles() {
        if let cached = getCachedArticles() {
            self.articles = cached
        } else {
            Task {
                await fetchArticlesFromAPI()
            }
        }
    }
    
    func saveArticles( _ articles: [Article]) {
        let encodedData = UserDefaults.standard.setObjects(articles.self, forKey: "Article")
    }
    
    func getCachedArticles() -> [Article]? {
        if let cachedArticle = UserDefaults.standard.getObject([Article].self, forKey: "Article") {
            return cachedArticle
        }
        return nil
    }
    
}
