//
//  DateFormatter+Extension.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 07/01/2025.
//

import Foundation

extension DateFormatter {
    static let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Full weekday name
        return formatter
    }()
}
