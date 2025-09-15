import Foundation
import CoreData

class AddNoteViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var selectedDate: Date = Date()
    @Published var isEditingTitle: Bool = false
    @Published var isEditingContent: Bool = false
    
    // Optional Note instance (used for editing)
    var note: Note?
    
    init(note: Note? = nil) {
        self.note = note
        self.title = note?.title ?? ""
        self.content = note?.content ?? ""
        self.selectedDate = note?.selectedDate ?? Date()
    }
    
    func saveNote(context: NSManagedObjectContext) -> Alerts {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedTitle.isEmpty else {
            return .emptyField
        }
        // Fetch duplicate titles (excluding current note being edited)
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND self != %@", trimmedTitle, note ?? NSNull())
        
        do {
            let duplicates = try context.fetch(fetchRequest)
            if !duplicates.isEmpty {
                return .duplicateField
            }
        } catch {
            print("Error checking duplicates: \(error)")
            return .failure
        }
        
        let noteToSave = note ?? Note(context: context)
        
        if noteToSave.id == nil {
            noteToSave.id = UUID()
        }
        
        noteToSave.title = title
        noteToSave.content = content
        noteToSave.selectedDate = selectedDate
        
        do {
            try context.save()
            print("Note saved successfully")
            return .success
        } catch {
            print("Failed to save note: \(error.localizedDescription)")
            return .failure
        }
    }
}
