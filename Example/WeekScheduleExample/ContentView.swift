//
//  ContentView.swift
//  WeekScheduleExample
//
//  Created by saudAlhafith on 24/01/2025.
//

import SwiftUI
import WeekSchedule

struct ContentView: View {
    
    @State var dayRange: DayRange = .weekdays
    @State var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            WeekScheduleView(entries: example)
                .scheduleDays(.weekdays, daySpacing: 4, dayFont: .system(size: 10), currentDayFont: .system(size: 12, weight: .bold), dayStyle: .wide) // Show weekdays with some styling
                .timelineIndicator(.red)
                .timelineRange(.entriesOnly) // Show 24-hour timeline
                .entryHeight(50, 80) // Set normal and expanded entry height
                .isEntryTimeShowing(true) // Show entry times
                .isEntryExpanded(true)
        }
    }
}

#Preview {
    ContentView()
}
