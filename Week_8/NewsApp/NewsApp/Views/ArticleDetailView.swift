import SwiftUI

struct ArticleDetailView: View {
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image("calendar")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.blue)
                        .frame(width: 20, height: 20)
                    
                    Text(article.publishedAt, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Image("author")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.blue)
                        .frame(width: 20, height: 20)
                    
                    Text(article.author ?? "Unknown")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Spacer()
                }
                
                Text(article.title)
                    .font(.title2)
                    .fontWeight(.bold)
                
                if let imageURL = article.urlToImage, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .cornerRadius(10)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                if let description = article.description {
                    Text(description)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                
                if let content = article.content {
                    Text(content.removeTruncatedTag())
                        .font(.body)
                        .foregroundColor(.primary)
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
