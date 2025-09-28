
import Foundation
import SwiftUICore

class SettingsViewModel: ObservableObject {
    @Published var selectedTheme: Theme {
        didSet {
            saveTheme()
        }
    }
    
    init() {
        if let savedTheme = UserDefaults.standard.string(forKey: "theme"), let theme = Theme(rawValue: savedTheme) {
            self.selectedTheme = theme
        } else {
            self.selectedTheme = .system
        }
    }
    
    func saveTheme() {
        UserDefaults.standard.set(selectedTheme.rawValue, forKey: "theme")
    }
    
    var colorScheme: ColorScheme? {
        switch selectedTheme {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
    
}
