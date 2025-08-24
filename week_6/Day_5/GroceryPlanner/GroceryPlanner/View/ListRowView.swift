import SwiftUI

struct ListRowView: View {
    @EnvironmentObject var groceryViewModel: GroceryViewModel
    var item: String
    @State var isChecked: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Toggle("", isOn: $isChecked)
                    .toggleStyle(CustomToggleStyle())
                Text("\(item)")
                    .padding(.leading, 10)
                    .font(.title3)
                Spacer()
            }
        }
    }
}

#Preview {
    //    ItemRowView()
}
