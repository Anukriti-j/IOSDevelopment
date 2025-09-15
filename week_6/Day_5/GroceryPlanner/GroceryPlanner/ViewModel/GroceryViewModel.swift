import UIKit

class GroceryViewModel: ObservableObject {
    
    @Published var groceryModelList: [GroceryCategoryModel] = []
    
    func addButtonTapped(newCategory: String, newGrocery: String) {
        let newItem = newGrocery.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !newCategory.isEmpty && !newItem.isEmpty {
            if let index = groceryModelList.firstIndex(where: { $0.category.capitalized == newCategory.capitalized }) {
                    groceryModelList[index].categoryItem.append(GroceryItemModel(itemName: newItem))
                appendToFile(model: groceryModelList, to: "Grocery.json")
            } else {
                let item = GroceryCategoryModel(category: newCategory, categoryItem: [GroceryItemModel(itemName: newItem)])
                groceryModelList.append(item)
                appendToFile(model: groceryModelList, to: "Grocery.json")
            }
        }
    }
    
    func removeRows(in category: GroceryCategoryModel, at offsets: IndexSet) {
        guard let sectionIndex = groceryModelList.firstIndex(where: { $0.id == category.id }) else {
            return
        }
        groceryModelList[sectionIndex].categoryItem.remove(atOffsets: offsets)
        if groceryModelList[sectionIndex].categoryItem.isEmpty {
            groceryModelList.remove(at: sectionIndex)
        }
    }
    
    func editItemName(itemID: UUID, newName: String) {
        if !newName.isEmpty {
            for categoryIndex in groceryModelList.indices {
                if let indexItem = groceryModelList[categoryIndex].categoryItem.firstIndex(where: { $0.id == itemID }) {
                    groceryModelList[categoryIndex].categoryItem[indexItem].itemName = newName
                    
                }
            }
        }
    }
    
    func moveItems(in category: GroceryCategoryModel, from source: IndexSet, to destination: Int) {
        guard let index = groceryModelList.firstIndex(where: { $0.id == category.id }) else { return }
    }
}
