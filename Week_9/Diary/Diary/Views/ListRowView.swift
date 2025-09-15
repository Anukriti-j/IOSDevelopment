import SwiftUI

struct ListRowView: View {
    @ObservedObject var note: Note
    
    var body: some View {
        HStack {
            Image("notes")
                .renderingMode(.template)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.pink)
            
            VStack(alignment: .leading) {
                Text(note.selectedDate?.formattedDate() ?? Date().formattedDate())
                    .foregroundColor(.gray)
                    .font(.caption)
                Text(note.title ?? "")
                    .font(.headline)
            }
            Spacer()
        }
    }
}


#Preview {
    ListRowView(note: Note())
}
