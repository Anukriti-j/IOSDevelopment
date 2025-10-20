import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct SignInView: View {
    @State private var viewModel = SignInViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                
                PrimaryButton(title: "Sign In", action: handleEmailSignIn)
                
                SocialButton(
                    title: "Continue with Google",
                    systemImage: "g.circle.fill",
                    color: Color.red,
                    action: handleGoogleSignIn
                )
                
                SocialButton(
                    title: "Continue with Facebook",
                    systemImage: "f.circle.fill",
                    color: .blue,
                    action: viewModel.signInWithFacebook
                )
                
                SocialButton(
                    title: "Continue with GitHub",
                    systemImage: "chevron.left.slash.chevron.right",
                    color: .black,
                    action: handleGitHubSignIn
                )
                
                SocialButton(
                    title: "Continue with Yahoo",
                    systemImage: "y.circle.fill",
                    color: .purple,
                    action: handleYahooSignIn
                )
                
                Spacer()
            }
            .padding()
            .navigationTitle("Sign In using Email")
            .alert(isPresented: $viewModel.presentAlert) {
                Alert(
                    title: Text("Invalid Input"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .cancel()
                )
            }
        }
    }
}

private extension SignInView {
    
    func handleEmailSignIn() {
        Task {
            do {
                try await viewModel.signUp()
                try validateAuthentication()
            } catch {
                print("Sign-up failed: \(error)")
                do {
                    try await viewModel.signIn()
                    try validateAuthentication()
                } catch {
                    print("Sign-in failed: \(error)")
                }
            }
        }
    }
    
    func handleGoogleSignIn() {
        Task {
            do {
                try await viewModel.signInGoogle()
                try validateAuthentication()
            } catch {
                print("Google sign-in failed: \(error)")
            }
        }
    }
    
    func handleGitHubSignIn() {
        Task { @MainActor in
            guard let topVC = Utilities.shared.topViewController() else {
                print("No top view controller found.")
                return
            }
            
            do {
                let user = try await viewModel.signInWithGitHub(presenting: topVC)
                print("Signed in with GitHub as \(user.email ?? "Unknown")")
                showSignInView = false
            } catch {
                print("GitHub sign-in failed: \(error.localizedDescription)")
            }
        }
    }
    
    func handleYahooSignIn() {
        Task { @MainActor in
            guard let topVC = Utilities.shared.topViewController() else { return }
            do {
                let user = try await viewModel.signInWithYahoo(presenting: topVC)
                print("Signed in as \(user.email ?? "Unknown")")
                showSignInView = false
            } catch {
                print("Yahoo sign-in failed: \(error.localizedDescription)")
            }
        }
    }
    
    func validateAuthentication() throws {
        if try AuthenticationManager.shared.getAuthenticatedUser() != nil {
            showSignInView = false
        } else {
            print("User not authenticated after sign in.")
        }
    }
}

#Preview {
    SignInView(showSignInView: .constant(true))
}
