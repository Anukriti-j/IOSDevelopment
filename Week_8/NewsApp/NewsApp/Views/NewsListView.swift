import SwiftUI

struct NewsListView: View {
    @StateObject private var newsViewModel = NewsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if newsViewModel.isInitialLoading {
                    ProgressView("Loading news...")
                } else if let errorMessage = newsViewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(newsViewModel.articles) { article in
                        NavigationLink {
                            ArticleDetailView(article: article)
                        } label: {
                            ArticleRowView(article: article)
                        }
                    }
                    .listStyle(.inset)
                    .refreshable {
                        await newsViewModel.fetchArticlesFromAPI()
                    }
                }
            }
            .navigationTitle("Top Headlines")
//            .task {
//                await newsViewModel.fetchArticlesFromAPI(isInitialLoad: true)
//            }
        }
    }
}
