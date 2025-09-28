import Foundation

enum TabSelection: String, Identifiable, CaseIterable {
    case Home, Settings
    var id: String { self.rawValue }
    
    var selectedItemLabel: String {
        switch self {
        case .Home:
            return "Home"
        case .Settings:
            return "Settings"
        }
    }
    
    var selectedImage: String {
        switch self {
        case .Home:
            return "plus"
        case .Settings:
            return "gear"
        }
    }
}
