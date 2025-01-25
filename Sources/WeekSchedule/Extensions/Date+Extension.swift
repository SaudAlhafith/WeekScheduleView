//
//  File.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 07/01/2025.
//

import Foundation

public extension Date {
    
    static var startOfCurrentWeek: Date {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) ?? today
        return weekStart
    }
    
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self.startOfDay) ?? .distantPast
    }
    
}
