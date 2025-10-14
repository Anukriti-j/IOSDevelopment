import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query private var items: [DataItem]
    
    var body: some View {
        VStack {
            Text("tap to add item")
            Button("Add") {
                addItem()
            }
            List {
                ForEach(items) { item in
                    Text("\(item.name),\(item.age)")
                }
                .onDelete { indexes in
                    for index in indexes {
                        deleteItem(items[index])
                    }
                }
            }
        }
        .padding()
    }
    
    func addItem() {
        // Create the item
        let item = DataItem(name: "Anukriti", age: 22)
        // Add the item to the data context
        context.insert(item)
    }
    
    func deleteItem(_ item: DataItem) {
        context.delete(item)
    }
}

#Preview {
    ContentView()
}
