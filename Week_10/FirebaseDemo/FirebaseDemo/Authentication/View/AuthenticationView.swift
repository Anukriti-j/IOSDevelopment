
import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                SignUpView()
            } label: {
                Text("Sign up using email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
                    
            }
            Spacer()
                .padding()
                .navigationTitle("Sign Up")
        }
    }
}

#Preview {
    AuthenticationView()
}
