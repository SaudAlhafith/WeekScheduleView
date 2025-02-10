//
//  CustomEntryExample.swift
//  WeekScheduleExample
//
//  Created by saudAlhafith on 31/01/2025.
//

import SwiftUI
import WeekSchedule

let sundayDate = Calendar.current.nextDate(after: .now, matching: DateComponents(weekday: 1), matchingPolicy: .nextTime) ?? .now

// Your actual data model
struct WorkoutSession: Identifiable {
    var id: UUID = UUID()
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
        return coach
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
        return Calendar.current.dateComponents([.hour, .minute, .weekday], from: sessionStart)
    }
    
    var endComponents: DateComponents {
        return Calendar.current.dateComponents([.hour, .minute, .weekday], from: sessionEnd)
    }
}

// Example View
import SwiftUI
import WeekSchedule

struct WorkoutScheduleView: View {
    
    var sessions: [WorkoutSession] = [
        WorkoutSession(
            exerciseName: "Yoga",
            coach: "Alice",
            sessionStart: sundayDate,
            sessionEnd: sundayDate.addingTimeInterval(80 * 60),
            intensityLevel: 1
        ),
        WorkoutSession(
            exerciseName: "HIIT",
            coach: "Bob",
            sessionStart: sundayDate.addingTimeInterval(7200), // +2 hours from start of day
            sessionEnd: sundayDate.addingTimeInterval(7200 + 80 * 60),
            intensityLevel: 3
        ),
        WorkoutSession(
            exerciseName: "Strength Training",
            coach: "Charlie",
            sessionStart: sundayDate.addingTimeInterval(14400), // +4 hours from start of day
            sessionEnd: sundayDate.addingTimeInterval(14400 + 80 * 60),
            intensityLevel: 2
        ),
        WorkoutSession(
            exerciseName: "Yoga",
            coach: "Alice",
            sessionStart: sundayDate.addingTimeInterval(86400), // Next day
            sessionEnd: sundayDate.addingTimeInterval(86400 + 80 * 60),
            intensityLevel: 1
        ),
        WorkoutSession(
            exerciseName: "HIIT",
            coach: "Bob",
            sessionStart: sundayDate.addingTimeInterval(7200 + 86400), // +2 hours on Monday
            sessionEnd: sundayDate.addingTimeInterval(7200 + 86400 + 80 * 60),
            intensityLevel: 3
        ),
        WorkoutSession(
            exerciseName: "Strength Training",
            coach: "Charlie",
            sessionStart: sundayDate.addingTimeInterval(14400 + 86400), // +4 hours on Monday
            sessionEnd: sundayDate.addingTimeInterval(14400 + 86400 + 80 * 60),
            intensityLevel: 2
        ),
    ]


    var body: some View {
        VStack {
            WeekSchedule(entries: sessions) { entry, day, options in
                VStack(alignment: .leading, spacing: 4) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(entry.title)
                            .font(.caption)
                            .bold()
                        if let subtitle = entry.subtitle {
                            Text(subtitle)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                    VStack {
                        Text(entry.startDate.formatted(.dateTime.hour().minute()))
                            .bold()
                        Text(entry.endDate.formatted(.dateTime.hour().minute()))
                            .bold()
                    }
                    .font(.system(size: 8))
                    .padding(.top, 2)

                }
                .padding(4)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(entry.color, lineWidth: 3)
                )
                .background(entry.color.opacity(0.3))
                .cornerRadius(10)
            }
            .dayRange(.custom(days: [.monday, .tuesday, .wednesday]))
            .timelineRange(.entriesOnly)
            .highlightToday(true)
            .background(Color.gray.opacity(0.1), in: .rect(cornerRadius: 20))
            .frame(height: UIScreen.main.bounds.height
                   * 0.4)
            Spacer()
        }
    }
}

#Preview {
    WorkoutScheduleView()
}
