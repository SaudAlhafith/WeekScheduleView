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
    
    func resolvedDays() -> [Weekday] {
        switch self {
        case .allDays:
            return Weekday.allCases
            
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
    var calendarIndex: Int {
        let calendar = Calendar.current
        let firstWeekday = calendar.firstWeekday
        return (self.rawValue - firstWeekday) % 7
    }
    
    /// Returns whether the weekday is today.
    var isToday: Bool {
        let today = Calendar.current.component(.weekday, from: Date())
        return self.rawValue == today
    }
    
    public enum Style {
        case wide
        case abbreviated
        case short
    }
    
    /// Returns the localized name of the weekday based on the given format style.
    func name(style: Style = .wide) -> String {
        let symbols = DateFormatter.weekdayFormatter.weekdaySymbols ?? []
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
    
    static var weekdaysForCurrentLocale: [Weekday] {
        let calendar = Calendar.current

        let weekendDays = calendar.weekendDays
        
        let weekDays = Weekday.allCases.filter { !weekendDays.contains($0) && $0 != .none }
        return weekDays
    }
    
    static var weekendForCurrentLocale: [Weekday] {
        return Array(Calendar.current.weekendDays)
    }
    
}
