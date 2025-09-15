import Foundation

struct GroceryItemModel: Identifiable, Codable {
    var id = UUID()
    var itemName: String
}

struct GroceryCategoryModel: Identifiable, Codable {
    var id = UUID()
    var category: String
    var categoryItem: [GroceryItemModel]
}
