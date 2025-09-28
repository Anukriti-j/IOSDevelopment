import SwiftUI
import CoreData

struct RootView: View {
    @Environment(\.managedObjectContext) var context
    @State var selectedTab: TabSelection = .Home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabSelection.allCases) { tab in
                passTabView(tab, context: context).tabItem {
                    Label(tab.selectedItemLabel, image: tab.selectedImage)
                }.tag(tab)
            }
        }
    }
}

@ViewBuilder
func passTabView(_ tab: TabSelection, context: NSManagedObjectContext) -> some View {
    switch tab {
    case .Home:
        ListView(context: context)
    case .Settings:
        SettingsView()
    }
}

#Preview {
    RootView()
}
