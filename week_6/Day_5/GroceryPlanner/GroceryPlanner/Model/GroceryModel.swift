import Foundation

struct GroceryItemModel: Identifiable {
    var id = UUID()
    var itemName: String
}

struct GroceryCategoryModel: Identifiable {
    var id = UUID()
    var category: String
    var categoryItem: [GroceryItemModel]
}
