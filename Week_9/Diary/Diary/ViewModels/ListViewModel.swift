import Foundation
import CoreData

class ListViewModel: ObservableObject {
    private let context = PersistenceController.shared.context
    @Published var notes: [Note] = []
    @Published var searchText: String = ""
    
    init() {
        fetchData()
    }
    
    func fetchData() -> Alerts {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Note.selectedDate, ascending: false)]
        do {
            notes = try context.fetch(request)
            return .success
        } catch {
            debugPrint("\(error.localizedDescription)")
            return .failure
        }
    }
    
    func deleteNote(at offsets: IndexSet) -> Alerts {
        for index in offsets {
            let noteToDelete = notes[index]
            context.delete(noteToDelete)
        }
        do {
            try context.save()
            fetchData()
            return .success
        } catch {
            print("\(error.localizedDescription)")
            return .failure
        }
    }
    
    func searchNotes() -> Alerts {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Note.selectedDate, ascending: false)]
        
        if !searchText.isEmpty {
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@ OR content CONTAINS[cd] %@", searchText, searchText)
        }
        
        do {
            notes = try context.fetch(request)
            return .success
        } catch {
            print("search error: \(error.localizedDescription)")
            return .failure
        }
    }
}
