import Foundation

enum AuthError: LocalizedError, Identifiable {
    var id: String { localizedDescription }
    
    case noCredential
    case noUser
    case userCancelled
    case missingTopViewController
    case noAuthenticatedUser
    case providerUnavailable
    case networkError(String)
    case unknown(String)
    
    var errorDescription: String? {
        switch self {
        case .noCredential:
            return "No authentication credential was returned by the provider."
        case .noUser:
            return "No user data was returned from authentication."
        case .userCancelled:
            return "The sign-in process was cancelled by the user."
        case .missingTopViewController:
            return "Unable to find a top view controller to present the sign-in flow."
        case .noAuthenticatedUser:
            return "No user is currently signed in."
        case .providerUnavailable:
            return "The selected authentication provider is not available."
        case .networkError(let message):
            return "Network error occurred: \(message)"
        case .unknown(let message):
            return "An unknown error occurred: \(message)"
        }
    }
}
