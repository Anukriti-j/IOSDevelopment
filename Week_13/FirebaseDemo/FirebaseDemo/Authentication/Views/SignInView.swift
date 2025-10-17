import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct SignInView: View {
    @State var viewModel: SignInViewModel = SignInViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                
                Button("Sign In") {
                    Task {
                        do {
                            try  await viewModel.signUp()
                            if try AuthenticationManager.shared.getAuthenticatedUser() != nil {
                                showSignInView = false
                            } else {
                                print("User not authenticated after sign up")
                            }
                            return
                        } catch {
                            print("\(error)")
                        }
                        
                        do {
                            try  await viewModel.signIn()
                            if try AuthenticationManager.shared.getAuthenticatedUser() != nil {
                                showSignInView = false
                            } else {
                                print("User not authenticated after sign in")
                            }
                            return
                        } catch {
                            print("\(error)")
                        }
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
                .shadow(radius: 4
                )
                
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .icon, state: .normal )) {
                    Task {
                        do {
                            try await viewModel.signInGoogle()
                            if try AuthenticationManager.shared.getAuthenticatedUser() != nil {
                                showSignInView = false
                            } else {
                                print("User not authenticated after Google sign-in")
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Sign In using Email")
            .alert(isPresented: $viewModel.presentAlert) {
                Alert(title: Text("Invalid Input"), message: Text("\(viewModel.alertMessage)"), dismissButton: .cancel())
            }
        }
        
        .padding()
    }
}

#Preview {
    SignInView(showSignInView: .constant(true))
}
