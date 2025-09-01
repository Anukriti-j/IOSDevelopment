import SwiftUI

struct GroceryListView: View {
    @EnvironmentObject var groceryViewModel: GroceryViewModel
    
    var body: some View {
        List {
            ForEach(groceryViewModel.groceryModelList) { category in
                Section(header: Text(category.category).textCase(.uppercase).foregroundColor(Color.black))
                {
                    ForEach(category.categoryItem) { item in
                        NavigationLink(destination: GroceryDetailView(item: item)) {
                            ListRowView(item: item.itemName)
                        }
                    }
                    .onDelete { indexSet in
                        groceryViewModel.removeRows(in: category, at: indexSet)
                    }
                    .onMove { IndexSet, newOffset in
                        groceryViewModel.moveItems(in: category, from: IndexSet, to: newOffset)
                    }
                }
            }
        }
    }
}

//#Preview {
//    ListCardView()
//        .environmentObject(GroceryViewModel)
//}
