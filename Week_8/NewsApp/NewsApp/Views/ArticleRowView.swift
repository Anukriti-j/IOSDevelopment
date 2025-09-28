import SwiftUI
import Kingfisher

struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        HStack(alignment: .top) {
            if let imageURL = article.urlToImage, let url = URL(string: imageURL) {
                KFImage(url)
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }
            
//            if let imageURL = article.urlToImage, let url = URL(string: imageURL) {
//                AsyncImage(url: url) { image in
//                    image.resizable()
//                        .scaledToFill()
//                } placeholder: {
//                    ProgressView()
//                }
//                .frame(width: 60, height: 60)
//                .cornerRadius(8)
//            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
            }
        }
    }
}

//#Preview {
//    ArticleRowView()
//}
