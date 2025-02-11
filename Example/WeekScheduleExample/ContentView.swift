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
            WeekSchedule(entries: example)
                .scheduleDays(.weekdays) // Show full week
                .timelineRange(.entriesOnly) // Show 24-hour timeline
                .highlightToday(false) // Disable today's highlight
                .entryNormalHeight(50) // Set normal entry height
                .entryExpandedHeight(80) // Set expanded entry height
                .isEntryTimeShowing(true) // Show entry times
                .isEntryExpanded(true)
        }
    }
}

#Preview {
    ContentView()
}
