/*

 WeekSchedule.swift
 WeekSchedule

 Created by saudAlhafith on 6/1/2025.
 Copyright © 2025 saudAlhafith. All rights reserved.

 MIT License

 Copyright 2025 saudAlhafith

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import SwiftUI

public struct WeekScheduleOptions {
    
    /// Determines the range of days displayed in the schedule.
    public var dayRange: DayRange = .weekdays
    
    /// Determines the range of hours displayed in the timeline.
    public var timelineRange: TimelineRange = .entriesOnly
    
    /// Determines whether to highlight today's entries
    public var highlightToday: Bool = true
    
    /// Height of each schedule entry.
    public var entryHeight: CGFloat = 50
    
    /// Height of each schedule entry when schedule expanded
    public var entryExpandedHeight: CGFloat = 70
    
    /// Vertical spacing between schedule days.
    public var daySpacing: CGFloat = 8
    
    /// Font used for the day
    public var dayFont: Font = .system(size: 14)
    
    /// Day format
    public var dayStyle: Weekday.Style = .wide
    
    /// Timeline hour font
    public var timelineFont: Font = .caption
    
    /// Font used for the title.
    public var titleFont: Font = .caption
    
    /// Font used for the subtitle.
    public var subtitleFont: Font = .caption2
    
    /// Font used for the title.
    public var timeFont: Font = .system(size: 9)
    
    public init() {}
    
}

public typealias EntryViewBuilder<EntryView: View, Entry: WeekScheduleEntry> = (_ entry: Entry, _ options: WeekScheduleOptions) -> EntryView

public struct WeekSchedule<EntryView: View, Entry: WeekScheduleEntry>: View {
    @Environment(\.layoutDirection) private var layoutDirection
    
    var entries: [Entry]
    var options: WeekScheduleOptions
    var entryViewBuilder: EntryViewBuilder<EntryView, Entry>
    
    public init(entries: [Entry], options: WeekScheduleOptions = WeekScheduleOptions(), @ViewBuilder entryViewBuilder: @escaping EntryViewBuilder<EntryView, Entry>) {
        self.entries = entries
        self.options = options
        self.entryViewBuilder = entryViewBuilder
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            HStack(alignment: .top) {
                timeline
                    .padding(.top, 14)
                HStack(alignment: .top, spacing: options.daySpacing){
                    ForEach(options.dayRange.resolvedDays(), id: \.rawValue) { day in
                        dayColumn(day)
                    }
                }
                .background(alignment: .top) {
                    VStack(spacing: 0){
                        ForEach(dayHoursInt, id: \.hashValue) { inf in
                            Rectangle()
                                .fill(.gray)
                                .frame(height: 1, alignment: .top)
                                .frame(height: options.entryHeight, alignment: .top)
                        }
                    }
                    .padding(.top, 20)
                }
            }
            .padding(.horizontal, 4)
            .frame(height: scheduleHeight)
        }
    }
    
    var timeline: some View {
        VStack(alignment: .trailing, spacing: 0){
            ForEach(dayHoursDate, id: \.hashValue) { hour in
                Text(hour.formatted(.dateTime.hour(.twoDigits(amPM: .abbreviated))))
                    .font(options.timelineFont)
                    .frame(height: options.entryHeight, alignment: .top)
            }
        }
    }
    
    @ViewBuilder func dayColumn(_ day: Weekday) -> some View {
            VStack(spacing: 0) {
                Text(day.name(style: options.dayStyle))
                    .font(options.dayFont)
                    .lineLimit(1)
                    .frame(height: 20, alignment: .top)
                ZStack(alignment: .top){
                    ForEach(getEntriesFor(day: day)) { entry in
                        entryViewBuilder(entry, options)
                            .frame(height: entry.entryHeight(entryHeight: options.entryHeight), alignment: .top)
                            .offset(y: entryYPosition(entry))
                    }
                }
            }
            .frame(maxWidth: .infinity)
    }
}

extension WeekSchedule where EntryView == WeekScheduleEntryView<Entry> {
    public init(entries: [Entry], options: WeekScheduleOptions) {
        self.entries = entries
        self.options = options
        self.entryViewBuilder = { entry, options in
            WeekScheduleEntryView(entry: entry, options: options)
        }
    }
}



