import FirebaseAuth
import FacebookCore
import FacebookLogin
import UIKit
import Foundation

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() {}
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.noAuthenticatedUser
        }
        return AuthDataResultModel(user: user)
    }
    
    func getProviders() throws -> [AuthProviderOptions] {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.noAuthenticatedUser
        }
        
        return user.providerData.compactMap { userInfo in
            guard let provider = AuthProviderOptions(rawValue: userInfo.providerID) else { return nil }
            return provider
        }
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: result.user)
    }
    
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: result.user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(
            withIDToken: tokens.idToken,
            accessToken: tokens.accessToken
        )
        return try await signIn(credential: credential)
    }
    
    func signInWithFacebook() async throws {
        guard let topVC = await Utilities.shared.topViewController() else {
            throw AuthError.missingTopViewController
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            let loginManager = LoginManager()
            
            loginManager.logIn(permissions: ["public_profile", "email"], from: topVC) { result, error in
                if let error = error {
                    return continuation.resume(throwing: error)
                }
                
                guard let result = result, !result.isCancelled else {
                    return continuation.resume(throwing: AuthError.userCancelled)
                }
                
                guard let tokenString = AccessToken.current?.tokenString else {
                    return continuation.resume(throwing: AuthError.noCredential)
                }
                
                let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
                
                Task {
                    do {
                        _ = try await self.signIn(credential: credential)
                        continuation.resume(returning: ())
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func signInWithGitHub(presenting: UIViewController) async throws -> AuthDataResultModel {
        let provider = OAuthProvider(providerID: "github.com")
        provider.customParameters = ["allow_signup": "false"]
        provider.scopes = ["user:email"]
        return try await signInWithOAuth(provider: provider)
    }
    
    func signInWithYahoo(presenting: UIViewController) async throws -> User {
        let provider = OAuthProvider(providerID: "yahoo.com")
        provider.customParameters = [
            "prompt": "login",
            "language": "en"
        ]
        return try await signInWithOAuthUser(provider: provider)
    }
    
    func signInWithOAuth(provider: OAuthProvider) async throws -> AuthDataResultModel {
        try await withCheckedThrowingContinuation { continuation in
            provider.getCredentialWith(nil) { credential, error in
                if let error = error {
                    return continuation.resume(throwing: error)
                }
                guard let credential = credential else {
                    return continuation.resume(throwing: AuthError.noCredential)
                }
                
                Task {
                    do {
                        let result = try await self.signIn(credential: credential)
                        continuation.resume(returning: result)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func signInWithOAuthUser(provider: OAuthProvider) async throws -> User {
        try await withCheckedThrowingContinuation { continuation in
            provider.getCredentialWith(nil) { credential, error in
                if let error = error {
                    return continuation.resume(throwing: error)
                }
                guard let credential = credential else {
                    return continuation.resume(throwing: AuthError.noCredential)
                }
                
                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        return continuation.resume(throwing: error)
                    }
                    guard let user = result?.user else {
                        return continuation.resume(throwing: AuthError.noUser)
                    }
                    continuation.resume(returning: user)
                }
            }
        }
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let result = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: result.user)
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw error
        }
    }
    
    func delete() async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.noAuthenticatedUser
        }
        try await user.delete()
    }
    
}
