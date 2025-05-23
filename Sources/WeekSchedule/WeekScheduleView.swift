/*
 
 WeekScheduleView.swift
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
    
    /// Vertical spacing between schedule days.
    public var daySpacing: CGFloat = 4
    
    /// Font used for the day
    public var dayFont: Font = .system(size: 10)
    
    /// Font used for the current day
    public var currentDayFont: Font = .system(size: 12, weight: .bold)
    
    /// 0 = off, 1 = full intensity
    public var highlightIntensity: Double = 1.0
    
    /// Day format
    public var dayStyle: Weekday.Style = .wide
    
    /// Height of each schedule entry when schedule expanded
    public var isEntryExpanded: Bool = false
    
    /// Height of each schedule entry.
    public var entryHeight: CGFloat {
        isEntryExpanded ? entryExpandedHeight : entryNormalHeight
    }
    
    /// Height of each schedule entry.
    public var entryNormalHeight: CGFloat = 50
    
    /// Height of each schedule entry when schedule expanded
    public var entryExpandedHeight: CGFloat = 70
    
    /// Timeline hour font
    public var timelineFont: Font = .system(size: 8)
    
    /// Timeline hour color
    public var timelineColor: Color = .gray
    
    /// Timeline hour color
    public var timelineIndicatorShowing: Bool = false
    
    /// Timeline hour color
    public var timelineIndicatorColor: Color = Color.accentColor
    
    /// Font used for the title.
    public var isEntryTimeShowing: Bool = false
    
    public init() {}
    
}

public typealias EntryViewBuilder<EntryView: View, Entry: WeekScheduleEntry> = (_ entry: Entry, _ day: Weekday, _ options: WeekScheduleOptions) -> EntryView
public typealias EntryOnClick<Entry : WeekScheduleEntry> = (_ entry: Entry) -> Void

public struct WeekScheduleView<EntryView: View, Entry: WeekScheduleEntry>: View {
    @Environment(\.layoutDirection) private var layoutDirection
    
    var entries: [Entry]
    var options: WeekScheduleOptions
    var entryViewBuilder: EntryViewBuilder<EntryView, Entry>
    var entryOnClick: EntryOnClick<Entry>
    
    public init(
        entries: [Entry],
        options: WeekScheduleOptions = WeekScheduleOptions(),
        @ViewBuilder entryViewBuilder: @escaping EntryViewBuilder<EntryView, Entry>,
        entryOnClick: @escaping EntryOnClick<Entry> = {_ in}
    ) {
        self.entries = entries
        self.options = options
        self.entryViewBuilder = entryViewBuilder
        self.entryOnClick = entryOnClick
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
                        ForEach(dayHoursInt.indices, id: \.self) { index in
                            let hour = dayHoursInt[index]
                            let prevHour = index >= 1 ? dayHoursInt[index - 1] : hour
                            let isSkippingHour = hour - prevHour > 1
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.gray)
                                .frame(height: isSkippingHour ? 3 : 1, alignment: .top)
                                .frame(height: options.entryHeight, alignment: .top)
                        }
                    }
                    .padding(.top, 20)
                }
                .overlay(alignment: .top) {
                    if options.timelineIndicatorShowing{
                        timelineIndicator
                    }
                }
                
            }
            .padding(4)
            .frame(height: scheduleHeight, alignment: .top)
        }
    }
    
    var timelineIndicator: some View {
        
        HStack(alignment: .center, spacing: 0){
            Image(systemName: "chevron.\(layoutDirection == .leftToRight ? "right" : "left")")
                .font(.caption2.bold())
                .foregroundStyle(options.timelineIndicatorColor)
            
            RoundedRectangle(cornerRadius: 2)
                .fill(options.timelineIndicatorColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .frame(height: 1.5)
        }
        .padding(.leading, -10)
        .offset(y: currentTimeLineY)
        .offset(y: 14.5)
    }
    
    var timeline: some View {
        VStack(alignment: .trailing, spacing: 0){
            ForEach(dayHoursDate, id: \.hashValue) { hour in
                Text(hour.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated))))
                    .font(options.timelineFont)
                    .foregroundColor(options.timelineColor)
                    .frame(height: options.entryHeight, alignment: .top)
            }
        }
    }
    
    @ViewBuilder func dayColumn(_ day: Weekday) -> some View {
        VStack(spacing: 0) {
            let isHighlighted = (day.isToday && options.highlightIntensity != 0)
            Text(day.name(style: options.dayStyle))
                .font(isHighlighted ? options.currentDayFont : options.dayFont)
                .foregroundColor(isHighlighted ? .primary : .gray)
                .lineLimit(1)
                .frame(height: 20, alignment: .top)
            ZStack(alignment: .top){
                ForEach(getEntriesFor(day: day)) { entry in
                    entryViewBuilder(entry, day, options)
                        .frame(maxHeight: entry.entryHeight(entryHeight: options.entryHeight), alignment: .top)
                        .onTapGesture {
                            entryOnClick(entry)
                        }
                        .offset(y: entryYPosition(entry))
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

extension WeekScheduleView where EntryView == WeekScheduleEntryView<Entry> {
    public init(
        entries: [Entry],
        options: WeekScheduleOptions = WeekScheduleOptions(),
        entryOnClick: @escaping EntryOnClick<Entry> = {_ in}
    ) {
        self.entries = entries
        self.options = options
        self.entryViewBuilder = { entry, day, options in
            return WeekScheduleEntryView(entry: entry, day: day, options: options)
        }
        self.entryOnClick = entryOnClick
    }
}

#Preview {
    WeekScheduleView(entries: [
        TimeTableEvent(
            title: "المترجمات",
            subtitle: "2157",
            color: .green,
            startComponents: DateComponents(hour: 8+0, minute: 25, weekday: 1),
            endComponents: DateComponents(hour: 9+0, minute: 15, weekday: 1)
        ),
        TimeTableEvent(
            title: "المترجمات",
            subtitle: "2157",
            color: .green,
            startComponents: DateComponents(hour: 9+0, minute: 20, weekday: 1),
            endComponents: DateComponents(hour: 10+0, minute: 10, weekday: 1)
        ),
        TimeTableEvent(
            title: "أمن المعلومات",
            subtitle: "3040",
            color: .red,
            startComponents: DateComponents(hour: 10+0, minute: 15, weekday: 1),
            endComponents: DateComponents(hour: 11+0, minute: 5, weekday: 1)
        ),
        TimeTableEvent(
            title: "أمن المعلومات",
            subtitle: "3040",
            color: .red,
            startComponents: DateComponents(hour: 11+0, minute: 10, weekday: 1),
            endComponents: DateComponents(hour: 12+0, minute: 0, weekday: 1)
        ),
        TimeTableEvent(
            title: "مبادئ قواعد البيانات",
            subtitle: "2029",
            color: .blue,
            startComponents: DateComponents(hour: 14+0, minute: 25, weekday: 1),
            endComponents: DateComponents(hour: 15+0, minute: 15, weekday: 1)
        ),
        TimeTableEvent(
            title: "مبادئ قواعد البيانات",
            subtitle: "2029",
            color: .blue,
            startComponents: DateComponents(hour: 15+0, minute: 20, weekday: 1),
            endComponents: DateComponents(hour: 16+0, minute: 10, weekday: 1)
        ),
        TimeTableEvent(
            title: "مبادئ قواعد البيانات",
            subtitle: "2029",
            color: .blue,
            startComponents: DateComponents(hour: 14+0, minute: 25, weekday: 2),
            endComponents: DateComponents(hour: 15+0, minute: 15, weekday: 2)
        ),
        TimeTableEvent(
            title: "مبادئ قواعد البيانات",
            subtitle: "2029",
            color: .blue,
            startComponents: DateComponents(hour: 15+0, minute: 20, weekday: 2),
            endComponents: DateComponents(hour: 16+01, minute: 0, weekday: 2)
        ),
    ], options: WeekScheduleOptions())
    .timelineIndicator(.red)
    .isEntryTimeShowing(true)
    .isEntryExpanded(true)
    .entryHeight(50, 90)
    .currentDayIntensity(1.0)
        .padding([.top, .horizontal], 6)
        .frame(maxHeight: .infinity)
        .background(.gray.opacity(0.1), in: .rect(cornerRadius: 15))
        .fixedSize()
}
