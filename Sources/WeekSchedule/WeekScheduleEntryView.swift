//
//  WeekScheduleEntryView.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 07/01/2025.
//

import SwiftUI

public struct WeekScheduleEntryView<Entry: WeekScheduleEntry>: View {
    
    public var entry: Entry
    public var options: WeekScheduleOptions
    public var entryHeight: CGFloat
    
    public init(entry: Entry, options: WeekScheduleOptions) {
        self.entry = entry
        self.options = options
        self.entryHeight = entry.entryHeight(entryHeight: options.entryHeight)
    }
    
    public var body: some View {
        VStack(spacing: 0){
            let _ = print(entryHeight)
            if entryHeight > 60 { // If enough space > 20 in entryHeight - title - subtitle
                Text(entry.startDate.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute()))
                    .font(.system(size: 9))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            VStack {
                Text(entry.title)
                    .font(.caption2)
                if let subtitle = entry.subtitle {
                    Text(subtitle)
                        .font(.system(size: 10))
                }
            }
            .frame(maxHeight: .infinity)
            if entryHeight > 60 { // If enough space > 20 in entryHeight - title - subtitle
                Text(entry.endDate.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute()))
                    .font(.system(size: 9))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(2)
        .multilineTextAlignment(.center)
        .frame(height: entryHeight)
        .frame(maxWidth: .infinity)
        .background(entry.color.opacity(0.3))
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(entry.color, lineWidth: 2)
        )
    }
    
}

#Preview {
    WeekSchedule(entries: [
        TimeTableEvent(
            title: "المترجمات",
            subtitle: "2157",
            color: .green,
            startComponents: DateComponents(hour: 8, minute: 25, weekday: 1),
            endComponents: DateComponents(hour: 9, minute: 15, weekday: 1)
        ),
        TimeTableEvent(
            title: "المترجمات",
            subtitle: "2157",
            color: .green,
            startComponents: DateComponents(hour: 9, minute: 20, weekday: 1),
            endComponents: DateComponents(hour: 10, minute: 10, weekday: 1)
        ),
        TimeTableEvent(
            title: "أمن المعلومات",
            subtitle: "3040",
            color: .red,
            startComponents: DateComponents(hour: 10, minute: 15, weekday: 1),
            endComponents: DateComponents(hour: 11, minute: 5, weekday: 1)
        ),
        TimeTableEvent(
            title: "أمن المعلومات",
            subtitle: "3040",
            color: .red,
            startComponents: DateComponents(hour: 11, minute: 10, weekday: 1),
            endComponents: DateComponents(hour: 12, minute: 0, weekday: 1)
        ),
        TimeTableEvent(
            title: "مبادئ قواعد البيانات",
            subtitle: "2029",
            color: .blue,
            startComponents: DateComponents(hour: 13, minute: 25, weekday: 1),
            endComponents: DateComponents(hour: 14, minute: 15, weekday: 1)
        ),
        TimeTableEvent(
            title: "مبادئ قواعد البيانات",
            subtitle: "2029",
            color: .blue,
            startComponents: DateComponents(hour: 14, minute: 20, weekday: 1),
            endComponents: DateComponents(hour: 15, minute: 10, weekday: 1)
        ),
        TimeTableEvent(
            title: "المترجمات",
            subtitle: "2157",
            color: .green,
            startComponents: DateComponents(hour: 8, minute: 25, weekday: 3),
            endComponents: DateComponents(hour: 9, minute: 15, weekday: 3)
        ),
        TimeTableEvent(
            title: "المترجمات",
            subtitle: "2157",
            color: .green,
            startComponents: DateComponents(hour: 9, minute: 20, weekday: 3),
            endComponents: DateComponents(hour: 10, minute: 10, weekday: 3)
        ),
        TimeTableEvent(
            title: "أمن المعلومات",
            subtitle: "3040",
            color: .red,
            startComponents: DateComponents(hour: 10, minute: 15, weekday: 3),
            endComponents: DateComponents(hour: 11, minute: 5, weekday: 3)
        ),
        TimeTableEvent(
            title: "أمن المعلومات",
            subtitle: "3040",
            color: .red,
            startComponents: DateComponents(hour: 11, minute: 10, weekday: 3),
            endComponents: DateComponents(hour: 12, minute: 0, weekday: 3)
        ),
        TimeTableEvent(
            title: "مبادئ قواعد البيانات",
            subtitle: "2029",
            color: .blue,
            startComponents: DateComponents(hour: 13, minute: 25, weekday: 3),
            endComponents: DateComponents(hour: 14, minute: 15, weekday: 3)
        ),
        TimeTableEvent(
            title: "مبادئ قواعد البيانات",
            subtitle: "2029",
            color: .blue,
            startComponents: DateComponents(hour: 14, minute: 20, weekday: 3),
            endComponents: DateComponents(hour: 15, minute: 10, weekday: 3)
        )
    ], options: WeekScheduleOptions())
}
