
import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signUp() {
        guard !email.isEmpty, !password.isEmpty else { return }
           
        Task {
            do {
                let userData = try await AuthenticationManager.shared.createuser(email: email, password: password)
                print("success")
                print(userData)
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}
