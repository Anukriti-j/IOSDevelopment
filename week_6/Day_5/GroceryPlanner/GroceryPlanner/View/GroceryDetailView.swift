import SwiftUI

struct GroceryDetailView: View {
    @EnvironmentObject var groceryViewModel: GroceryViewModel
    @State private var updateItem = ""
    let item: GroceryItemModel
    
    init(item: GroceryItemModel) {
        self.item = item
        self.updateItem = updateItem
    }
    
    var body: some View {
        VStack {
            Text("Edit Grocery")
                .padding()
                .foregroundColor(Color.blue)
                .font(.headline)
            TextField("Edit", text: $updateItem)
                .onChange(of: updateItem, perform: { newValue in
                    groceryViewModel.editItemName(itemID: item.id, newName: newValue)
                })
                .padding()
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Grocery Detail")
            Spacer()
        }
    }
}

//#Preview {
//    GroceryDetailView(item: <#GroceryItemModel#>)
//}
