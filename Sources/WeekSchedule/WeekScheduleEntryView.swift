//
//  WeekScheduleEntryView.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 07/01/2025.
//

import SwiftUI

public struct WeekScheduleEntryView<Entry: WeekScheduleEntry>: View {
    
    var entry: Entry
    var options: WeekScheduleOptions
    
    public var body: some View {
        ZStack{
            VStack {
                Text(entry.startDate.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute()))
                    .font(options.timeFont)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text(entry.endDate.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute()))
                    .font(options.timeFont)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            VStack {
                Text(entry.title)
                    .font(options.titleFont)
                if let subtitle = entry.subtitle {
                    Text(subtitle)
                        .font(options.subtitleFont)
                }
            }
        }
        .padding(2)
        .multilineTextAlignment(.center)
        .frame(height: entry.entryHeight(entryHeight: options.entryHeight))
        .frame(maxWidth: .infinity)
        .background(entry.color.opacity(0.3))
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(entry.color, lineWidth: 2)
        )

        
        
    }
    
}

//#Preview {
//    WeekSchedule(entries: exampleEvents, options: WeekScheduleOptions())
//}
