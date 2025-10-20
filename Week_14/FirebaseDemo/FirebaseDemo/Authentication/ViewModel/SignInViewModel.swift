import SwiftUI
import FirebaseAuth

@MainActor
@Observable
final class SignInViewModel: NSObject {
    var email: String = ""
    var password: String = ""
    var alertMessage: String = ""
    var presentAlert: Bool = false
    
    func signUp() async throws {
        guard validateEmailAndPassword() else { return }
        _ = try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func signIn() async throws {
        guard validateEmailAndPassword() else { return }
        _ = try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
    
    func signInWithFacebook() {
        Task {
            do {
                try await AuthenticationManager.shared.signInWithFacebook()
                print("Facebook sign-in successful.")
            } catch {
                print("Facebook sign-in failed: \(error.localizedDescription)")
            }
        }
    }
    
    func signInWithGitHub(presenting: UIViewController) async throws -> AuthDataResultModel {
        try await AuthenticationManager.shared.signInWithGitHub(presenting: presenting)
    }
    
    func signInWithYahoo(presenting: UIViewController) async throws -> User {
        try await AuthenticationManager.shared.signInWithYahoo(presenting: presenting)
    }
    
    private func validateEmailAndPassword() -> Bool {
        guard !email.isEmpty else {
            showAlert(InputFieldValidation.emptyEmail.alertMessage)
            return false
        }
        
        guard !password.isEmpty else {
            showAlert(InputFieldValidation.emptyPassword.alertMessage)
            return false
        }
        
        guard password.count >= 6 else {
            showAlert(InputFieldValidation.passwordvalidation.alertMessage)
            return false
        }
        
        return true
    }
    
    private func showAlert(_ message: String) {
        alertMessage = message
        presentAlert = true
    }
}
