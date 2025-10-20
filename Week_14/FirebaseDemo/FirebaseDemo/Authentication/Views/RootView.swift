import SwiftUI

struct RootView: View {
    @State private var showSignInView = false
    @State private var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        ZStack {
            NavigationStack {
                SettingsView(viewModel: settingsViewModel, showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil ? true : false
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                SignInView(showSignInView: $showSignInView)
            }
        }
        .onChange(of: showSignInView) { _, newValue in
            if !newValue {
                settingsViewModel.loadAuthProviders()
            }
        }
    }
}

#Preview {
    RootView()
}
