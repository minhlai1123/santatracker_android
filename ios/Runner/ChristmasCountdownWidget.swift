import WidgetKit
import SwiftUI

// MARK: - Timeline Entry
struct ChristmasWidgetEntry: TimelineEntry {
    let date: Date
    let daysLeft: Int
    let isEvenDay: Bool
}

// MARK: - Timeline Provider
struct ChristmasWidgetTimelineProvider: TimelineProvider {
    typealias Entry = ChristmasWidgetEntry

    func placeholder(in context: Context) -> ChristmasWidgetEntry {
        ChristmasWidgetEntry(date: Date(), daysLeft: calculateDaysLeft(from: Date()), isEvenDay: isEven(date: Date()))
    }

    func getSnapshot(in context: Context, completion: @escaping (ChristmasWidgetEntry) -> ()) {
        let entry = ChristmasWidgetEntry(date: Date(), daysLeft: calculateDaysLeft(from: Date()), isEvenDay: isEven(date: Date()))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ChristmasWidgetEntry>) -> ()) {
        var entries: [ChristmasWidgetEntry] = []
        let currentDate = Date()

        for hourOffset in 0 ..< 12 {
            if let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate) {
                let days = calculateDaysLeft(from: entryDate)
                let even = isEven(date: entryDate)
                entries.append(ChristmasWidgetEntry(date: entryDate, daysLeft: days, isEvenDay: even))
            }
        }

        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate) ?? currentDate
        let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
        completion(timeline)
    }

    private func calculateDaysLeft(from date: Date) -> Int {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        var components = DateComponents()
        components.year = year
        components.month = 12
        components.day = 25
        components.hour = 0
        components.minute = 0
        components.second = 0

        guard var targetDate = calendar.date(from: components) else { return 0 }
        if date > targetDate {
            components.year = year + 1
            targetDate = calendar.date(from: components) ?? targetDate
        }

        let startOfCurrent = calendar.startOfDay(for: date)
        let startOfTarget = calendar.startOfDay(for: targetDate)
        let diff = calendar.dateComponents([.day], from: startOfCurrent, to: startOfTarget)
        return max(0, diff.day ?? 0)
    }

    private func isEven(date: Date) -> Bool {
        let day = Calendar.current.component(.day, from: date)
        return day % 2 == 0
    }
}

// MARK: - Widget View (SwiftUI)
struct ChristmasCountdownWidgetEntryView: View {
    var entry: ChristmasWidgetTimelineProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        ZStack {
            // Festive Winter Evergreen Gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.08, green: 0.24, blue: 0.20),
                    Color(red: 0.11, green: 0.30, blue: 0.24),
                    Color(red: 0.05, green: 0.16, blue: 0.13)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 4) {
                // Header Row
                HStack(spacing: 5) {
                    Text("🎄")
                        .font(.system(size: 13))
                    Text("Christmas Countdown")
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.99, green: 0.94, blue: 0.54))
                        .lineLimit(1)
                    Spacer(minLength: 0)
                }

                Spacer(minLength: 0)

                // Big Countdown Number
                Text("\(entry.daysLeft)")
                    .font(.system(size: family == .systemSmall ? 36 : 44, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)

                // Unit Label
                Text(entry.daysLeft == 1 ? "DAY UNTIL CHRISTMAS" : (entry.daysLeft == 0 ? "TODAY IS CHRISTMAS!" : "DAYS UNTIL CHRISTMAS"))
                    .font(.system(size: 9.5, weight: .heavy, design: .rounded))
                    .foregroundColor(Color(red: 0.82, green: 0.98, blue: 0.90))
                    .tracking(0.5)

                Spacer(minLength: 0)

                // Even-Day Special / Status Badge
                HStack(spacing: 3) {
                    if entry.isEvenDay {
                        Text("✨ Even-Day Special Active")
                            .font(.system(size: 9, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.99, green: 0.94, blue: 0.54))
                    } else {
                        Text("🎄 Daily Holiday Cheer")
                            .font(.system(size: 9, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.88, green: 0.95, blue: 0.99))
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.12))
                        .overlay(Capsule().stroke(Color(red: 0.91, green: 0.75, blue: 0.39).opacity(0.6), lineWidth: 0.8))
                )
            }
            .padding(12)
        }
        .widgetURL(URL(string: "chrimastsatastracker://countdown"))
    }
}

// MARK: - Widget Configuration
struct ChristmasCountdownWidget: Widget {
    let kind: String = "ChristmasCountdownWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ChristmasWidgetTimelineProvider()) { entry in
            ChristmasCountdownWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Christmas Countdown")
        .description("Track the magical countdown to Christmas and see special even-day surprises right on your Home Screen.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
