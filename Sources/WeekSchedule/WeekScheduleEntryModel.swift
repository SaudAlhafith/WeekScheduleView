//
//  TimeTableEntry.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 07/01/2025.
//

import Foundation
import SwiftUI

// MARK: - Protocol
public protocol WeekScheduleEntry: Identifiable {
    var title: String { get set }
    var subtitle: String? { get set }
    var color: Color { get set }
    var startComponents: DateComponents { get set }
    var endComponents: DateComponents { get set }
}

// MARK: - Default Implementation
public extension WeekScheduleEntry {
    
    var startDate: Date {
        startComponents.dateForWeek(weekStart: Date.startOfCurrentWeek)
    }
    
    var endDate: Date {
        endComponents.dateForWeek(weekStart: Date.startOfCurrentWeek)
    }
    var startDay: Weekday { Weekday(rawValue: startDate.weekday - 2) ?? .none }
    var endDay: Weekday { Weekday(rawValue: endDate.weekday - 2) ?? .none }
    var startHour: Int { startDate.hour }
    var startMinute: Int { startDate.minute }
    var endHour: Int { endDate.hour }
    var endMinute: Int { endDate.minute }
    
    func entryHeight(entryHeight: CGFloat) -> CGFloat {
        let duration = abs(endHour - startHour) * 60 + endMinute - startMinute
        let minuteHeight = entryHeight / 60
        
        return CGFloat(duration) * minuteHeight
    }
    
}

// MARK: - Default Struct
public struct TimeTableEvent: WeekScheduleEntry {
    public var id: UUID = UUID()
    public var title: String
    public var subtitle: String?
    public var color: Color
    public var startComponents: DateComponents
    public var endComponents: DateComponents
    
    public init(id: UUID = UUID(), title: String, subtitle: String? = nil, color: Color, startComponents: DateComponents, endComponents: DateComponents) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.color = color
        self.startComponents = startComponents
        self.endComponents = endComponents
    }
    
}


