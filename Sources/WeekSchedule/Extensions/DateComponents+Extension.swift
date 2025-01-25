//
//  File.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 07/01/2025.
//

import Foundation

public extension DateComponents {
    
    func dateForWeek(weekStart: Date = Date.startOfCurrentWeek) -> Date {
        return Calendar.current.date(byAdding: self, to: weekStart) ?? weekStart
    }
    
}
