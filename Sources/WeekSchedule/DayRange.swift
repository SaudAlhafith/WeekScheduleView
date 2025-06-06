//
//  DayRange.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 07/01/2025.
//

import Foundation

/// Specifies the range of days displayed in the schedule.
public enum DayRange {
    /// Displays all days from Sunday to Saturday.
    case allDays
    
    /// Displays only weekdays (Monday to Friday).
    case weekdays
    
    /// Displays a custom range of days.
    /// - Parameter days: An array of `Weekday` values to specify the custom days.
    case custom(days: [Weekday])
    
    /// Returns whether the range contains the given day.
    func contains(_ day: Weekday) -> Bool {
        switch self {
        case .allDays:
            return true
            
        case .weekdays:
            return Weekday.weekdaysForCurrentLocale.contains(day)
            
        case .custom(let days):
            return days.contains(day)
        }
    }
    
    func contains<Entry: WeekScheduleEntry>(_ entry: Entry) -> Bool {
        switch self {
        case .allDays:
            return true
            
        case .weekdays:
            let startDayIncluded = Weekday.weekdaysForCurrentLocale.contains(entry.startDay)
            let endDayIncluded = Weekday.weekdaysForCurrentLocale.contains(entry.endDay)
            return startDayIncluded || endDayIncluded
            
        case .custom(let days):
            let startDayIncluded = days.contains(entry.startDay)
            let endDayIncluded = days.contains(entry.endDay)
            return startDayIncluded || endDayIncluded
        }
    }
    
    func resolvedDays() -> [Weekday] {
        switch self {
        case .allDays:
            let firstWeekday = Calendar.current.firstWeekday
            return (firstWeekday...(firstWeekday+7)).compactMap {
                return Weekday(rawValue: ($0 + 7) % 7) // To get local order
            }
            
        case .weekdays:
            return Weekday.weekdaysForCurrentLocale
            
        case .custom(let days):
            return days
        }
    }
}

public enum Weekday: Int, CaseIterable {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    case none
    
    /// Returns the correct weekday index based on the current calendar and locale.
    public var calendarIndex: Int {
        let calendar = Calendar.current
        return ((self.rawValue - 1) + 7) % 7
    }
    
    /// Returns whether the weekday is today.
    public var isToday: Bool {
        let today = Calendar.current.component(.weekday, from: Date())
        return self.rawValue == today
    }
    
    public enum Style {
        case wide
        case abbreviated
        case short
    }
    
    /// Returns the localized name of the weekday based on the given format style.
    public func name(style: Style = .wide) -> String {
        guard let symbols = DateFormatter.weekdayFormatter.weekdaySymbols else {
            return "N/A"
        }

        let name = symbols[calendarIndex]
                
        switch style {
        case .wide:
            return name
        case .abbreviated:
            return String(name.prefix(3)) // "Tuesday" -> "Tue"
        case .short:
            return String(name.prefix(2)) // "Tuesday" -> "Tu"
        }
    }
    
    public static var weekdaysForCurrentLocale: [Weekday] {
        let calendar = Calendar.current

        let weekendDays = calendar.weekendDays
        
        let weekDays = Weekday.allCases.filter { !weekendDays.contains($0) && $0 != .none }
        return weekDays
    }
    
    public static var weekendForCurrentLocale: [Weekday] {
        return Array(Calendar.current.weekendDays)
    }
    
}
