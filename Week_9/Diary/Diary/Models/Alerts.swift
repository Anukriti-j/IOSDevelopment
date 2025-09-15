enum Alerts {
    case emptyField
    case duplicateField
    case success
    case failure
    
    var alertMessage: String {
        switch self {
        case .emptyField:
            return "Title cannot be left empty"
        case .duplicateField:
            return "Title exists"
        case .success:
            return "Success"
        case .failure:
            return "An unexpected error occurred"
        }
    }
}
