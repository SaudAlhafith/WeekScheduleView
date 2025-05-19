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
            Button("Expand Schedule") {
                withAnimation(.snappy) {
                    isExpanded.toggle()
                }
            }
            WeekScheduleView(entries: example) { entry, day, options in
                let entryHeight = entry.entryHeight(entryHeight: options.entryHeight)
                let isToday = day.isToday
                    VStack(spacing: 0){
                        if options.isEntryTimeShowing {
                            Text(entry.startDate.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute()))
                                .font(.system(size: 9))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .transition(.opacity.animation(.snappy.delay(0.2)))
                        }
                        VStack {
                            Text(entry.title)
                                .font(.caption2)
                            if let subtitle = entry.subtitle {
                                Text(subtitle)
                                    .font(.system(size: 10))
                            }
                            if let description = entry.description {
                                Text(description)
                                    .font(.system(size: 8))
                            }
                        }
                        .frame(maxHeight: .infinity)
                        if options.isEntryTimeShowing {
                            Text(entry.endDate.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute()))
                                .font(.system(size: 9))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .transition(.opacity.animation(.snappy.delay(0.2)))
                        }
                    }
                    .padding(2)
                    .multilineTextAlignment(.center)
                    .frame(height: entryHeight)
                    .frame(maxWidth: .infinity)
                    .background(entry.color.opacity(0.3), in: .rect(cornerRadius: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(entry.color, lineWidth: 2)
                    )
                    .brightness(
                        isToday
                        ? (0.1 * (options.highlightIntensity * 0.5))
                        : (options.highlightIntensity * -0.1)
                    )
                    .saturation(
                        isToday
                        ? (1.0 + options.highlightIntensity)
                        : (1.0 - (options.highlightIntensity * 0.5))
                    )
            }
                .scheduleDays(.custom(days: [.sunday, .monday, .tuesday, .wednesday, .thursday]), daySpacing: 4, dayFont: .system(size: 10), dayStyle: .wide) // Show weekdays with some styling
                .timelineIndicator(.red)
                .timelineRange(.entriesOnly) // Show 24-hour timeline
                .entryHeight(50, 80) // Set normal and expanded entry height
                .isEntryTimeShowing(isExpanded) // Show entry times
                .isEntryExpanded(isExpanded)
        }
    }
}

#Preview {
    ContentView()
}
