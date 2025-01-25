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
                .dayRange(dayRange)
                .dayStyle(.wide)
                .isEntryExpanded(isExpanded)
                .frame(height: 300)
            Button("Expand Schedule") {
                withAnimation(.snappy) {
                    isExpanded.toggle()
                }
            }
            Button("Change Day Range To All Days") {
                withAnimation(.snappy) {
                    dayRange = .allDays
                }
            }
            Button("Change Day Range To Weekdays") {
                withAnimation(.snappy) {
                    dayRange = .weekdays
                }
            }
            Button("Change Day Range To Custom Range") {
                withAnimation(.snappy) {
                    dayRange = .custom(days: [.monday, .wednesday])
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
