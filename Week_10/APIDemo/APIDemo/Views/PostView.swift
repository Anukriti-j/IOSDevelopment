import SwiftUI

struct PostView: View {
    @StateObject private var postViewModel = PostViewModel()
    var id: Int
    
    var body: some View {
        VStack {
            if postViewModel.initialLoading {
                ProgressView("Loading...")
            } else {
                List {
                    ForEach(postViewModel.posts) { post in
                        VStack {
                            Text(post.title)
                            Text(post.body)
                        }
                       
                    }
                }
            }
        }.onAppear {
            Task {
                await postViewModel.fetchPosts(userId: id)
            }
        }
    }
}
//
//#Preview {
//    PostView()
//}
