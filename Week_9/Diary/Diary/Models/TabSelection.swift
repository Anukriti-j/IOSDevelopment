import Foundation

enum TabSelection: String,Identifiable, CaseIterable {
    case home, settings
    var id: String { self.rawValue }
    
    var tabItemLabel: String {
        switch self {
        case .home: return "Home"
        case .settings: return "Settings"
        }
    }
    var tabItemImage: String {
        switch self {
        case .home: return "house.fill"
        case .settings: return "gear"
        }
    }
}
