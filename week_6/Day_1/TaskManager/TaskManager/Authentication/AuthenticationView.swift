import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        VStack {
            NavigationLink {
                Text("Sign up with email")
            } label: {
                Text("Sign Up with Email")
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .frame(width: .infinity)
                    .frame(height: 50)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}

#Preview {
    AuthenticationView()
}
