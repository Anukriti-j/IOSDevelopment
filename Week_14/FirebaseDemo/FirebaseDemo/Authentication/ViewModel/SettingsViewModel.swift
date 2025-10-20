import Foundation
import Observation

@Observable
final class SettingsViewModel {
    var authProviders: [AuthProviderOptions] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func logOut()  throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func deleteAccount() async {
        do {
            try await AuthenticationManager.shared.delete()
        } catch {
            print(error)
        }
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw AuthError.providerUnavailable
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
}
