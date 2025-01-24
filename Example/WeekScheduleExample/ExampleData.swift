//
//  FakeData.swift
//  WeekScheduleExample
//
//  Created by saudAlhafith on 25/01/2025.
//

import Foundation
import WeekSchedule

let example: [TimeTableEvent] = [
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
]
