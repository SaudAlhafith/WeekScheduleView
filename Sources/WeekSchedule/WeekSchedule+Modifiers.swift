//
//  File.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 25/01/2025.
//

import SwiftUI

public extension WeekSchedule {
    
    /// Sets the range of hours displayed in the timeline.
    func timelineRange(_ timelineRange: TimelineRange = .entriesOnly) -> WeekSchedule {
        var view = self
        view.options.timelineRange = timelineRange
        return view
    }
    
    /// Enables or disables highlighting today's entries.
    func highlightToday(_ value: Bool = true) -> WeekSchedule {
        var view = self
        view.options.highlightToday = value
        return view
    }
    
    /// Sets the height of each schedule entry.
    func isEntryExpanded(_ isEntryExpanded: Bool) -> WeekSchedule {
        var view = self
        view.options.isEntryExpanded = isEntryExpanded
        return view
    }
    
    /// Sets the height of each schedule entry.
    func entryNormalHeight(_ height: CGFloat) -> WeekSchedule {
        var view = self
        view.options.entryNormalHeight = height
        return view
    }
    
    /// Sets the height of each schedule entry when expanded.
    func entryExpandedHeight(_ height: CGFloat) -> WeekSchedule {
        var view = self
        view.options.entryExpandedHeight = height
        return view
    }
    
    /// Sets the day range to display in the schedule, adjust spacing between days, and customize the day font.
    func scheduleDays(
        dayRange: DayRange = .weekdays,
        daySpacing: CGFloat = 4,
        dayFont: Font = .system(size: 10),
        currentDayFont: Font = .system(size: 12, weight: .bold),
        dayStyle: Weekday.Style = .wide
    ) -> WeekSchedule {
        var view = self
        view.options.dayRange = dayRange
        view.options.daySpacing = daySpacing
        view.options.dayFont = dayFont
        view.options.currentDayFont = currentDayFont
        view.options.dayStyle = dayStyle
        return view
    }
    
    
    /// Sets the font used for the time labels.
    func timeline(_ color: Color, font: Font) -> WeekSchedule {
        var view = self
        view.options.timelineFont = font
        view.options.timelineColor = color
        return view
    }
    
    func timelineIndicator(_ color: Color) -> WeekSchedule {
        var view = self
        view.options.timelineIndicatorShowing = true
        view.options.timelineIndicatorColor = color
        return view
    }
    
    /// Sets the font for the time labels.
    func isEntryTimeShowing(_ isEntryTimeShowing: Bool) -> WeekSchedule {
        var view = self
        view.options.isEntryTimeShowing = isEntryTimeShowing
        return view
    }
}

