import SwiftUI

struct ListView: View {
    @StateObject private var listViewModel = ListViewModel()
    @State private var addSheetPresented = false
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(listViewModel.notes) { note in
                    NavigationLink(destination: {
                        AddNoteView(note: note, listViewModel: listViewModel)
                    }) {
                        ListRowView(note: note)
                    }
                }
                .onDelete { offsets in
                    let result = listViewModel.deleteNote(at: offsets)
                    if result != .success {
                        alertMessage = result.alertMessage
                        showAlert = true
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
            }
            .navigationTitle("My Notes")
            .searchable(text: $listViewModel.searchText)
            .onChange(of: listViewModel.searchText) {
                let result = listViewModel.searchNotes()
                if result != .success {
                    alertMessage = result.alertMessage
                    showAlert = true
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.medium)
                            .padding(12)
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $addSheetPresented) {
                AddNoteView(listViewModel: listViewModel)
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("\(alertMessage)")
            }
            
        }
    }
}

#Preview {
    ListView()
}
