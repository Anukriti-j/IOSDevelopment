import SwiftUI

struct RootView: View {
    @State private var showSignUpScreen: Bool = false
    
    var body: some View {
        NavigationStack {
            SettingsView(showSignUpScreen: $showSignUpScreen)
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignUpScreen = authUser == nil ? true : false
        }
        .fullScreenCover(isPresented: $showSignUpScreen) {
            SignUpView()
        }
    }
}

#Preview {
    RootView()
}
