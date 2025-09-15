import SwiftUI

struct CalendarView: View {
    @ObservedObject var addNoteViewModel: AddNoteViewModel
    @State private var showFullCalendar = false
    
    var body: some View {
        VStack {
            HStack {
                Text(addNoteViewModel.selectedDate.formattedDate())
                Spacer()
                Button {
                    showFullCalendar.toggle()
                } label: {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding()
                }
            }
            
            if showFullCalendar {
                DatePicker("Select Date", selection: $addNoteViewModel.selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .green.opacity(0.4), radius: 3, x: 0, y: 1)
        )
        .padding()
    }
}
