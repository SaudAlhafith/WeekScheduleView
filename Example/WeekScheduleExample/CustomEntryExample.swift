//
//  CustomEntryExample.swift
//  WeekScheduleExample
//
//  Created by saudAlhafith on 31/01/2025.
//

import SwiftUI
import WeekSchedule

// Your actual data model
struct WorkoutSession {
    var exerciseName: String
    var coach: String?
    var sessionStart: Date
    var sessionEnd: Date
    var intensityLevel: Int
}

// Extend it to conform to WeekScheduleEntry
extension WorkoutSession: WeekScheduleEntry {
    var title: String {
        return exerciseName
    }
    
    var subtitle: String? {
        return coach != nil ? "Coach: \(coach!)" : nil
    }
    
    var color: Color {
        switch intensityLevel {
        case 1: return .green
        case 2: return .orange
        case 3: return .red
        default: return .gray
        }
    }
    
    var startComponents: DateComponents {
        return Calendar.current.dateComponents([.hour, .minute], from: sessionStart)
    }
    
    var endComponents: DateComponents {
        return Calendar.current.dateComponents([.hour, .minute], from: sessionEnd)
    }
    
    var id: ObjectIdentifier {
        return ObjectIdentifier(self as AnyObject)
    }
}

// Example View
struct WorkoutScheduleView: View {
    var sessions: [WorkoutSession] = [
        WorkoutSession(exerciseName: "Yoga", coach: "Alice", sessionStart: Date(), sessionEnd: Date().addingTimeInterval(3600), intensityLevel: 1),
        WorkoutSession(exerciseName: "HIIT", coach: "Bob", sessionStart: Date().addingTimeInterval(7200), sessionEnd: Date().addingTimeInterval(9000), intensityLevel: 3)
    ]

    var body: some View {
        WeekSchedule(entries: entries) { entry, options in
            VStack(alignment: .leading) {
                Text(entry.title)
                    .font(options.titleFont)
                Text(entry.subtitle)
                    .font(options.subtitleFont)
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(8)
        }
        .dayRange(.weekdays)
        .timelineRange(.entriesOnly)
        .highlightToday(true)
    }
}

#Preview {
    CustomEntryExample()
}
