import SwiftUI

struct SignUpView: View {
    @StateObject private var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        NavigationStack {
            TextField("Email...", text: $signUpViewModel.email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password...", text: $signUpViewModel.password)
                .textFieldStyle(.roundedBorder)
            Button {
                signUpViewModel.signUp()
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}

#Preview {
    SignUpView()
}
