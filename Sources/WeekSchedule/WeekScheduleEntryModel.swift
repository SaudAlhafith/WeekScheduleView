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
    var title: String { get }
    var subtitle: String? { get }
    var description: String? { get }
    var color: Color { get }
    var startComponents: DateComponents { get }
    var endComponents: DateComponents { get }
}

// MARK: - Default Implementation
public extension WeekScheduleEntry {
    
    var description: String? {
        return nil
    }
    
    var startDate: Date {
        startComponents.dateForWeek(weekStart: Date.startOfCurrentWeek)
    }
    
    var endDate: Date {
        endComponents.dateForWeek(weekStart: Date.startOfCurrentWeek)
    }
    var startDay: Weekday { Weekday(rawValue: startComponents.weekday ?? 8) ?? .none }
    var endDay: Weekday { Weekday(rawValue: startComponents.weekday ?? 8) ?? .none }
    var startHour: Int { startDate.hour }
    var startMinute: Int { startDate.minute }
    var endHour: Int { endDate.hour }
    var endMinute: Int { endDate.minute }
    
    func entryHeight(entryHeight: CGFloat) -> CGFloat {
        let endHour = endHour == 0 ? 24 : endHour
        
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
