//
//  ContentView.swift
//  WeekScheduleExample
//
//  Created by saudAlhafith on 24/01/2025.
//

import SwiftUI
import WeekSchedule

struct ContentView: View {
    
    
    
    var body: some View {
        VStack {
            WeekSchedule(
                entries: example) { entry, options in
                    Text(entry.title)
                }
        }
    }
}

#Preview {
    ContentView()
}
