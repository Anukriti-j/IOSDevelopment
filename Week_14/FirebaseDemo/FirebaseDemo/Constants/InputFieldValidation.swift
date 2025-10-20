import Foundation

enum InputFieldValidation {
    case emptyEmail
    case emptyPassword
    case passwordvalidation
    
    var alertMessage: String {
        switch self {
        case .emptyEmail:
            "Email cannot be left empty"
        case .emptyPassword:
            "Please enter password to proceed"
        case .passwordvalidation:
            "Please enter atleast 6 characters for password"
        }
    }
}
