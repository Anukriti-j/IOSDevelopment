import SwiftUI

struct HomeView: View {
    @State private var selectedTab: TabSelection = .home
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                ForEach(TabSelection.allCases) { tab in
                    tabView(for: tab)
                        .tabItem {
                            Label(tab.tabItemLabel , systemImage: tab.tabItemImage)
                        }
                        .tag(tab)
                }
            }
            .tint(.pink)
        }
    }
    
    @ViewBuilder
    private func tabView(for tab: TabSelection) -> some View {
        switch tab {
        case .home:
            ListView()
        case .settings:
            SettingsView()
        }
    }
}
//
//#Preview {
//    HomeView()
//}
