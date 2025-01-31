# WeekSchedule

[![Latest release](https://img.shields.io/github/v/release/SaudAlhafith/WeekScheduleView?color=brightgreen&label=version)](https://github.com/SaudAlhafith/WeekScheduleView/releases/latest)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FSaudAlhafith%2FWeekScheduleView%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/SaudAlhafith/WeekScheduleView)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FSaudAlhafith%2FWeekScheduleView%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/SaudAlhafith/WeekScheduleView)
[![](https://img.shields.io/badge/SPM-supported-DE5C43.svg?color=brightgreen)](https://swift.org/package-manager/)
![](https://img.shields.io/github/license/2FSaudAlhafith/WeekScheduleView)

[![contact: @SaudAlhafith](https://img.shields.io/badge/contact-%40SaudAlhafith-blue.svg?style=flat)](https://t.me/SaudAlhafith)

<p align="left">
<img src="Sources/Gifs/teaser.jpg" alt="WeekScheduleView" width="600">
</p>

**WeekSchedule** is a SwiftUI package designed to help you easily create and manage weekly schedules in your iOS and macOS applications. Whether you're building a calendar app, a task scheduler, or a time management tool, `WeekSchedule` provides a flexible and customizable way to display and interact with weekly timelines.

---

## Features

- **Customizable Weekly View**: Display a week's schedule with customizable day ranges (e.g., weekdays only or full week).
- **Dynamic Timeline Range**: Show only the hours with entries or a full 24-hour timeline.
- **Highlight Today**: Easily highlight today's entries for better visibility.
- **Expandable Entries**: Allow entries to expand for more details.
- **Custom Fonts and Styles**: Customize fonts for days, timeline, titles, subtitles, and time labels.
- **RTL Support**: Fully supports right-to-left languages like Arabic and Hebrew.
- **Flexible Entry Views**: Use custom views for schedule entries or the default `WeekScheduleEntryView`.

---

## Requirements

- iOS 15.0+
- macOS 12.0+

---

## Installation

### Swift Package Manager

To integrate `WeekSchedule` into your project using SwiftPM, add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/SaudAlhafith/WeekScheduleView", from: "0.1.0"),
],
```

Or add it directly in Xcode:

1. Go to `File` > `Add Packages...`.
2. Enter the repository URL: `https://github.com/SaudAlhafith/WeekScheduleView`.
3. Select the version you want to use.

---

## Usage

### Basic Example

Here's how to create a simple workout schedule:

![Workout Schedule View](https://github.com/SaudAlhafith/WeekScheduleView/blob/main/Assets/WorkoutScheduleView.png?raw=true)


```swift
import SwiftUI
import WeekSchedule

struct WorkoutScheduleView: View {
    
    var sessions: [WorkoutSession] = [
        // ...
    ]

    var body: some View {
        VStack {
            WeekSchedule(entries: sessions) { entry, options in
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
```

### Customizing the Schedule

You can customize the schedule using the provided modifiers:

```swift
WeekSchedule(entries: entries)
    .dayRange(.fullWeek) // Show full week
    .timelineRange(.fullDay) // Show 24-hour timeline
    .highlightToday(false) // Disable today's highlight
    .entryNormalHeight(50) // Set normal entry height
    .entryExpandedHeight(100) // Set expanded entry height
    .daySpacing(10) // Add spacing between days
    .dayFont(.headline) // Customize day font
    .timelineFont(.caption) // Customize timeline font
    .titleFont(.title3) // Customize title font
    .subtitleFont(.subheadline) // Customize subtitle font
    .timeFont(.caption2) // Customize time font
    .isEntryTimeShowing(true) // Show entry times
```

---

## Custom Entry Views

You can provide custom views for schedule entries using the `entryViewBuilder` closure:

```swift
WeekSchedule(entries: entries) { entry, options in
    HStack {
        Text(entry.title)
            .font(options.titleFont)
        Spacer()
        Text(entry.subtitle)
            .font(options.subtitleFont)
    }
    .padding()
    .background(Color.green.opacity(0.2))
    .cornerRadius(8)
}
```

---

## Supporting Right-to-Left Languages

`WeekSchedule` fully supports right-to-left (RTL) languages. Simply set the environment's layout direction:

```swift
WeekSchedule(entries: entries)
    .environment(\.layoutDirection, .rightToLeft)
```

---

## Communication

- If you **found a bug**, open an issue or submit a fix via a pull request.
- If you **have a feature request**, open an issue or submit an implementation via a pull request.
- If you **want to contribute**, submit a pull request onto the `main` branch.

---

## License

`WeekSchedule` is released under the MIT license. See the [LICENSE](LICENSE) file for more details.
