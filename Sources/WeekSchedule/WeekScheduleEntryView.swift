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
            if options.isEntryTimeShowing {
                Text(entry.startDate.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute()))
                    .font(options.timeFont)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            VStack {
                Text(entry.title)
                    .font(options.titleFont)
                if let subtitle = entry.subtitle {
                    Text(subtitle)
                        .font(options.subtitleFont)
                }
            }
            .frame(maxHeight: .infinity)
            if options.isEntryTimeShowing {
                Text(entry.endDate.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute()))
                    .font(options.timeFont)
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

//#Preview {
//    WeekSchedule(entries: exampleEvents, options: WeekScheduleOptions())
//}
