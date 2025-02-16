//
//  File.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 25/01/2025.
//

import SwiftUI

public extension WeekScheduleView {
    
    /// Sets the range of hours displayed in the timeline.
    func timelineRange(_ timelineRange: TimelineRange = .entriesOnly) -> WeekScheduleView {
        var view = self
        view.options.timelineRange = timelineRange
        return view
    }
    
    /// Sets the day range to display in the schedule, adjust spacing between days, and customize the day font.
    func scheduleDays(
        _ dayRange: DayRange,
        daySpacing: CGFloat = 4,
        dayFont: Font = .system(size: 10),
        currentDayFont: Font = .system(size: 12, weight: .bold),
        dayStyle: Weekday.Style = .wide
    ) -> WeekScheduleView {
        var view = self
        view.options.dayRange = dayRange
        view.options.daySpacing = daySpacing
        view.options.dayFont = dayFont
        view.options.currentDayFont = currentDayFont
        view.options.dayStyle = dayStyle
        return view
    }
    
    
    /// Sets the font used for the time labels.
    func timeline(_ color: Color, font: Font) -> WeekScheduleView {
        var view = self
        view.options.timelineFont = font
        view.options.timelineColor = color
        return view
    }
    
    func timelineIndicator(_ color: Color) -> WeekScheduleView {
        var view = self
        view.options.timelineIndicatorShowing = true
        view.options.timelineIndicatorColor = color
        return view
    }
    
    /// Sets the Entry height per hour in normal case and in the expanded case.
    func entryHeight(_ entryNormalHeight: CGFloat, _ entryExpandedHeight: CGFloat) -> WeekScheduleView {
        var view = self
        view.options.entryNormalHeight = entryNormalHeight
        view.options.entryExpandedHeight = entryExpandedHeight
        return view
    }
        
    /// Sets the height of each schedule entry.
    func isEntryExpanded(_ isEntryExpanded: Bool) -> WeekScheduleView {
        var view = self
        view.options.isEntryExpanded = isEntryExpanded
        return view
    }
    
    /// Sets the font for the time labels.
    func isEntryTimeShowing(_ isEntryTimeShowing: Bool) -> WeekScheduleView {
        var view = self
        view.options.isEntryTimeShowing = isEntryTimeShowing
        return view
    }
}

