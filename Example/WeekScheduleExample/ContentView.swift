//
//  ContentView.swift
//  WeekScheduleExample
//
//  Created by saudAlhafith on 24/01/2025.
//

import SwiftUI
import WeekSchedule

struct ContentView: View {
    var body: some View {
        VStack {
            WeekSchedule(
                entries: [
                    TimeTableEvent(title: "Hello", color: .red, startComponents: DateComponents(hour: 8, weekday:2), endComponents: DateComponents(hour: 9, weekday:2))
                ]
            )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
