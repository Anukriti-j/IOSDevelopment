import Foundation

enum AuthenticationErrors: String, Error {
    case noAuthenticatedUser = "No current Authenticated user"
    case noProviders = "No providers found"
    case noUserToDelete = "User not found to delete"
    case resetPasswordError = "Error resetting password"
}
