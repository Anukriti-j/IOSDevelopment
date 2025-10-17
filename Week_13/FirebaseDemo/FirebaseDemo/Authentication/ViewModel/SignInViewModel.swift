import Foundation
import SwiftUI
import GoogleSignIn
import FirebaseAuth

@MainActor
@Observable
final class SignInViewModel {
    var email: String = ""
    var password: String = ""
    var alertMessage = ""
    var presentAlert: Bool = false
    
    func signUp() async throws {
        guard !email.isEmpty else {
            alertMessage = InputFieldValidation.emptyEmail.alertMessage
            presentAlert = true
            return
        }
        
        guard !password.isEmpty else {
            alertMessage = InputFieldValidation.emptyPassword.alertMessage
            presentAlert = true
            return
        }
        
        guard password.count >= 6 else {
            alertMessage = InputFieldValidation.passwordvalidation.alertMessage
            presentAlert = true
            return
        }
        _ = try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("Fields cannot be left empty")
            return
        }
        _ = try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}


