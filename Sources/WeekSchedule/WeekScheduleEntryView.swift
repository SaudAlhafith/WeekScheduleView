//
//  WeekScheduleEntryView.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 07/01/2025.
//

import SwiftUI

public struct WeekScheduleEntryView<Entry: WeekScheduleEntry>: View {
    
    public var entry: Entry
    public var day: Weekday
    public var options: WeekScheduleOptions
    public var entryHeight: CGFloat
    
    private let isToday: Bool
    
    public init(entry: Entry, day: Weekday, options: WeekScheduleOptions) {
        self.entry = entry
        self.day = day
        self.options = options
        self.entryHeight = entry.entryHeight(entryHeight: options.entryHeight)
        self.isToday = day.isToday
    }
    
    public var body: some View {
        VStack(spacing: 0){
            if options.isEntryTimeShowing {
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
                if let description = entry.description {
                    Text(description)
                        .font(.system(size: 9))
                }
            }
            .frame(maxHeight: .infinity)
            if options.isEntryTimeShowing { 
                Text(entry.endDate.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute()))
                    .font(.system(size: 9))
                    .frame(maxWidth: .infinity, alignment: .trailing)
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
        .brightness(isToday ? 0.1 : -0.1)
        .saturation(isToday ? 1.3 : 1.0)
        .opacity(isToday ? 1.0 : 0.8)
    }
    
}
