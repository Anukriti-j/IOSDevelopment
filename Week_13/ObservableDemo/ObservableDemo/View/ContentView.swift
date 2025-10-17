import SwiftUI

struct ContentView: View {
    @State private var viewModel = UserViewModel(
        user: User(
            name: "Anukriti",
            age: 22,
            followerCount: 100
        )
    )
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.user.name)
            Text("\(viewModel.user.age)")
            Text("\(viewModel.user.followerCount)")
            Button {
                viewModel.increaseFollower()
            } label: {
                Text("Add follower")
            }
            .buttonStyle(.bordered)
            .padding(10)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
