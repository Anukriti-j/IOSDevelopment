import SwiftUI
import CoreData

struct AddNoteView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var addNoteViewModel: AddNoteViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    var note: Note?
    var listViewModel: ListViewModel?
    
    enum Field {
        case title, content
    }
    
    init(note: Note? = nil, listViewModel: ListViewModel? = nil) {
        self.note = note
        self.listViewModel = listViewModel
        _addNoteViewModel = StateObject(wrappedValue: AddNoteViewModel(note: note))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    CalendarView(addNoteViewModel: addNoteViewModel)
                    HeadlineView(headline: "Title")
                    
                    if addNoteViewModel.isEditingTitle {
                        TextField("Title", text: $addNoteViewModel.title)
                            .focused($focusedField, equals: .title)
                            .onSubmit {
                                addNoteViewModel.isEditingTitle = false
                                focusedField = nil
                            }
                    } else {
                        Text(addNoteViewModel.title.isEmpty ? "Tap to add title" : addNoteViewModel.title)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .onTapGesture {
                                addNoteViewModel.isEditingTitle = true
                                // To resolve Warning: Publishing changes from within view updates is not allowed
                                DispatchQueue.main.async {
                                    focusedField = .title
                                }
                            }
                    }
                    
                    HeadlineView(headline: "Content")
                    if addNoteViewModel.isEditingContent {
                        TextEditor(text: $addNoteViewModel.content)
                            .focused($focusedField, equals: .content)
                            .frame(height: 200)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2)))
                    } else {
                        Text(addNoteViewModel.content.isEmpty ? "Tap to add content" : addNoteViewModel.content)
                            .frame(alignment: .leading)
                            .padding()
                            .cornerRadius(8)
                            .onTapGesture {
                                addNoteViewModel.isEditingContent = true
                                DispatchQueue.main.async {
                                    focusedField = .content
                                }
                            }
                    }
                }
                .padding()
            }
            .navigationTitle(addNoteViewModel.note == nil ? "Add Note" : "Edit Note")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let result = addNoteViewModel.saveNote(context: context)
                        switch result {
                        case .success:
                            listViewModel?.fetchData()
                            dismiss()
                        case .emptyField, .duplicateField, .failure:
                            alertMessage = result.alertMessage
                            showAlert = true
                        }
                        focusedField = nil
                    }
                    .disabled(addNoteViewModel.title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .alert("Alert", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
}

//#Preview {
//    AddNoteView()
//}
struct HeadlineView: View {
    let headline: String
    var body: some View {
        Text(headline)
            .font(.caption)
            .textCase(.uppercase)
            .foregroundColor(.gray)
            .bold()
            .padding(.horizontal)
    }
}
