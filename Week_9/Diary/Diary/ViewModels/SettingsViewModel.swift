import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var selectedTheme: Theme {
        didSet {
            saveSelectedTheme()
        }
    }
    
    private let themeKey = "selectedTheme"
    
    init() {
        if let savedTheme = UserDefaults.standard.string(forKey: themeKey),
           let theme = Theme(rawValue: savedTheme) {
            self.selectedTheme = theme
        } else {
            self.selectedTheme = .system
        }
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
    
    func saveSelectedTheme() {
        UserDefaults.standard.set(selectedTheme.rawValue, forKey: themeKey)
    }
    
    func resetSettings() {
        self.selectedTheme = .system
    }
}
