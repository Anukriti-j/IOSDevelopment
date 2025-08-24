
import SwiftUI

struct SheetView: View {
    @EnvironmentObject var groceryViewModel: GroceryViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var showingSheet: Bool
    @State private var newGrocery: String = ""
    @State private var newCategory: String = ""
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.footnote)
                        .foregroundColor(Color.red)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 10)
                .padding(.trailing, 20)
                
                Spacer()
                
                Button {
                    groceryViewModel.addButtonTapped(newCategory: newCategory, newGrocery: newGrocery)
                    dismiss()
                } label: {
                    Text("Add")
                        .font(.footnote)
                        .foregroundColor(Color.black)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 10)
                .padding(.leading, 20)
            }
            .padding()
            
            TextField("Category", text: $newCategory)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            TextField("Item", text: $newGrocery)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
//
//#Preview {
//    SheetView()
//}
