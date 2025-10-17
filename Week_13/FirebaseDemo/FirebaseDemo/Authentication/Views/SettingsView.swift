import SwiftUI

struct SettingsView: View {
    @Bindable var viewModel: SettingsViewModel
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Log out") {
                do {
                    try viewModel.logOut()
                    showSignInView = true
                } catch {
                    print(error)
                }
            }
            
            Button(role: .destructive) {
                Task {
                    await viewModel.deleteAccount()
                    showSignInView = true
                }
            } label: {
                Text("Delete Account")
            }
            
            if viewModel.authProviders.contains(.email) {
                Button("Reset Password") {
                    Task {
                        do {
                            try await viewModel.resetPassword()
                            print("password reset")
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadAuthProviders()
            print(viewModel.authProviders)
        }
        .navigationBarTitle("Settings")
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(), showSignInView: .constant(true))
}
