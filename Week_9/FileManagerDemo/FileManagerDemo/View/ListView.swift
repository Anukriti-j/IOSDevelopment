import SwiftUI

struct ListView: View {
    @StateObject var studentViewModel: StudentViewModel = StudentViewModel()
    let storage = StudentStorage.shared
    @State private var isSheetPresented: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(studentViewModel.studentList) { student in
                    HStack {
                        Text("I am")
                        Text(student.name)
                    }
                }
            }
            .listStyle(.insetGrouped)
            Button {
                isSheetPresented.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .clipShape(Circle())
            }
            
        }
        .sheet(isPresented: $isSheetPresented, content: {
            EditListView(viewModel: studentViewModel)
        })
        .padding()
    }
}

#Preview {
    ListView()
}
