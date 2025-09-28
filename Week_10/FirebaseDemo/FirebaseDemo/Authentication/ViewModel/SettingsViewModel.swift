import Foundation

class SettingsViewModel: ObservableObject {
    @Published var showSignUpScreen: Bool = false
    
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
