//
//  WeekSchedule+Helpers.swift
//  WeekSchedule
//
//  Created by saudAlhafith on 07/01/2025.
//

import SwiftUI
 
extension WeekSchedule {
    
    var scheduleHeight: CGFloat {
        return CGFloat(dayHoursInt.count + 1) * options.entryHeight
    }
    
    // MARK: Timeline Hours Logic

    var entriesHours : Set<Int> {
        var hourAdded : Set<Int> = []
        
        for entry in entries {
            var endHour = entry.endHour
            if entry.endMinute == 0 && endHour - 1 >= entry.startHour {
                endHour -= 1
            }
            
            if entry.startHour <= endHour {
                (entry.startHour...endHour).forEach{hourAdded.insert($0)}
            }
        }
        
        return hourAdded
    }
    
    var minHour: Int { return entriesHours.min() ?? 0}
    var maxHour: Int { return entriesHours.max() ?? 0}
    
    var dayHoursInt: [Int] {
        let startOfDay = Date.now.startOfDay
        
        var lowerBound: Int = 0
        var upperBound: Int = 0
        
        switch options.timelineRange {
        case .minToMaxEntryHours:
            lowerBound = minHour
            upperBound = maxHour
        case .entriesOnly:
            let hoursInt = Array(entriesHours).sorted()
            
            return hoursInt
        case .fullDay:
            lowerBound = 0
            upperBound = 24
        case .custom(startHour: let startHour, endHour: let endHour):
            lowerBound = startHour
            upperBound = endHour
        }
        
        let hoursInt = Array(lowerBound..<upperBound).sorted()
        
        return hoursInt
    }
    
    var dayHoursDate: [Date] {
        let startOfDay = Date.now.startOfDay
        
        var lowerBound: Int = 0
        var upperBound: Int = 0
        
        switch options.timelineRange {
        case .minToMaxEntryHours:
            lowerBound = minHour
            upperBound = maxHour
        case .entriesOnly:
            let hoursDate = (entriesHours).compactMap { hour in
                Calendar.current.date(byAdding: .hour, value: hour, to: startOfDay)
            }
            
            return hoursDate.sorted()
        case .fullDay:
            lowerBound = 0
            upperBound = 24
        case .custom(startHour: let startHour, endHour: let endHour):
            lowerBound = startHour
            upperBound = endHour
        }

        let hoursDate = (lowerBound..<upperBound).compactMap { hour in
            Calendar.current.date(byAdding: .hour, value: hour, to: startOfDay)
        }
                
        return hoursDate.sorted()
    }
    
    var currentTimeLineY: CGFloat {
        let nowHourMinute = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour = nowHourMinute.hour ?? 0
        let minute = nowHourMinute.minute ?? 0
        
        let timeInMinutes = (hour * 60 + minute)
        
        guard timeInMinutes >= (minHour * 60),
              !entries.isEmpty else { return 0 }
        
        guard timeInMinutes < (maxHour * 60) else {
            return CGFloat(dayHoursInt.count) * options.entryHeight
        }
        
        let minuteHeight = options.entryHeight / 60
        
        let currentTimeLineY = CGFloat(timeInMinutes - (minHour * 60)) * minuteHeight
        
        return currentTimeLineY
        
    }
    
    // MARK: Entry Logic
    // The position of the entry will be based on the index in entriesHours if certain variable is true
    
    func getEntriesFor(day: Weekday) -> [Entry] {
        var dayEntries: [Entry] = []
        let dayHoursInt = Set(dayHoursInt) // For fast lookup
        for entry in entries {
            if (entry.startDay == day || entry.endDay == day)
                && (dayHoursInt.contains(entry.startHour) || dayHoursInt.contains(entry.endHour)) {
                dayEntries.append(entry)
            }
        }
        return dayEntries
    }
    
    func entryYPosition(_ entry: Entry) -> CGFloat {
        let minuteHeight = options.entryHeight / 60
        var entryYPosition: CGFloat = 0
        
        if let entrySlot = self.dayHoursInt.firstIndex(of: entry.startHour) {
            entryYPosition = CGFloat(entrySlot) * 60
        }
        
        entryYPosition += CGFloat(entry.startMinute)
        
        return entryYPosition * minuteHeight
    }
    
}

#Preview {
    WeekSchedule(entries: [
        TimeTableEvent(
            title: "المترجمات",
            subtitle: "2157",
            color: .green,
            startComponents: DateComponents(hour: 8, minute: 25),
            endComponents: DateComponents(hour: 9, minute: 15)
        ),
        TimeTableEvent(
            title: "المترجمات",
            subtitle: "2157",
            color: .green,
            startComponents: DateComponents(hour: 9, minute: 20),
            endComponents: DateComponents(hour: 10, minute: 10)
        ),
        TimeTableEvent(
            title: "أمن المعلومات",
            subtitle: "3040",
            color: .red,
            startComponents: DateComponents(hour: 10, minute: 15),
            endComponents: DateComponents(hour: 11, minute: 5)
        ),
        TimeTableEvent(
            title: "أمن المعلومات",
            subtitle: "3040",
            color: .red,
            startComponents: DateComponents(hour: 11, minute: 10),
            endComponents: DateComponents(hour: 12, minute: 0)
        ),
        TimeTableEvent(
            title: "مبادئ قواعد البيانات",
            subtitle: "2029",
            color: .blue,
            startComponents: DateComponents(hour: 13, minute: 25),
            endComponents: DateComponents(hour: 14, minute: 15)
        ),
        TimeTableEvent(
            title: "مبادئ قواعد البيانات",
            subtitle: "2029",
            color: .blue,
            startComponents: DateComponents(hour: 14, minute: 20),
            endComponents: DateComponents(hour: 15, minute: 10)
        )
    ], options: WeekScheduleOptions())
}

