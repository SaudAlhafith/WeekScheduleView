//
//  File.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 25/01/2025.
//

import SwiftUI

public extension WeekSchedule {
    
    /// Sets the range of days displayed in the schedule.
    func dayRange(_ dayRange: DayRange = .weekdays) -> WeekSchedule {
        var view = self
        view.options.dayRange = dayRange
        return view
    }
    
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
    
    /// Sets the vertical spacing between schedule days.
    func daySpacing(_ spacing: CGFloat) -> WeekSchedule {
        var view = self
        view.options.daySpacing = spacing
        return view
    }
    
    /// Sets the font used for the day labels.
    func dayFont(_ font: Font) -> WeekSchedule {
        var view = self
        view.options.dayFont = font
        return view
    }
    
    /// Sets the day style format.
    func dayStyle(_ style: Weekday.Style) -> WeekSchedule {
        var view = self
        view.options.dayStyle = style
        return view
    }
    
    /// Sets the font for the timeline hour labels.
    func timelineFont(_ font: Font) -> WeekSchedule {
        var view = self
        view.options.timelineFont = font
        return view
    }
    
    /// Sets the font for the time labels.
    func isEntryTimeShowing(_ isEntryTimeShowing: Bool) -> WeekSchedule {
        var view = self
        view.options.isEntryTimeShowing = isEntryTimeShowing
        return view
    }
}

