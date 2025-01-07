//
//  Calendar+Extension.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 07/01/2025.
//

import Foundation

extension Calendar {
    
    var weekendDays: Set<Weekday> {
        var weekendDays = Set<Weekday>()
        
        for weekday in Weekday.allCases {
            var components = DateComponents()
            components.weekday = weekday.rawValue + 1 // Adjust for Calendar's 1-based index.
            
            if let date = self.date(from: components), isDateInWeekend(date) {
                weekendDays.insert(weekday)
            }
        }
        return weekendDays
    }
    
}
