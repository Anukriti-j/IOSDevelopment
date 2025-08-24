import SwiftUI
import ElegantCalendar

struct CalendarViewWrapper: View {
    @StateObject private var calendarManager = ElegantCalendarManager(
        configuration: CalendarConfiguration(
            calendar: Calendar.current,
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .year, value: 1, to: Date())!
        )
    )
    var body: some View {
        ElegantCalendarView(calendarManager: calendarManager)
            .onAppear {
                calendarManager.scrollToMonth(Date())
            }
    }
}

#Preview {
    CalendarViewWrapper()
}
