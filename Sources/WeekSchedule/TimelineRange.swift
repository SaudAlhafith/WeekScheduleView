//
//  TimelineRange.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 07/01/2025.
//

import Foundation

/// Specifies the range of hours displayed in the week schedule.
///
/// Options include showing hours from the earliest to latest entry, only hours with entries, a full day, or a custom range.
/// For `.custom(startHour:endHour)`, ensure `startHour` ≤ `endHour` to avoid issues.
enum TimelineRange {
    /// From the earliest entry's start hour to the latest entry's end hour.
    case minToMaxEntryHours
    
    /// Only hours that have corresponding entries.
    case entriesOnly
    
    /// All hours from 00:00 to 24:00.
    case fullDay
    
    /// Custom range of hours (e.g., 9 to 17).
    /// `startHour` must be ≤ `endHour`.
    case custom(startHour: Int, endHour: Int)
}
