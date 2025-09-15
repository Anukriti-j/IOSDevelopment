import SwiftUI

struct ListView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    @State var sheetPresented: Bool = false
    @AppStorage("title") private var title: String = ""
    
    var body: some View {
        NavigationStack {
            TextField("title", text: $title)
            List {
                ForEach(viewModel.studentList) { item in
                    VStack {
                        Text("\(title)")
                        Text("\(item.name ?? "unknown")")
                        Text("\(item.age ?? 0)")
                    }
                }
                .onDelete(perform: viewModel.deleteRow)
            }
            .listStyle(.inset)
            Button("Add") {
                sheetPresented.toggle()
            }
        }
        .padding()
        .sheet(isPresented: $sheetPresented) {
            sheetView(viewModel: viewModel)
        }
        .navigationTitle("Students list")
    }
    
}

#Preview {
    ListView()
}
