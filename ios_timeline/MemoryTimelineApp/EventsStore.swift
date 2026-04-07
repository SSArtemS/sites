import Foundation

@MainActor
final class EventsStore: ObservableObject {
    @Published private(set) var events: [TimelineEvent] = []

    private let storageKey = "timeline_events_v1"

    init() {
        load()
    }

    func addEvent(title: String, date: Date, imageBase64: String?) {
        let event = TimelineEvent(title: title, date: date, imageBase64: imageBase64)
        events.append(event)
        events.sort { $0.date < $1.date }
        save()
    }

    private func load() {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let decoded = try? JSONDecoder().decode([TimelineEvent].self, from: data)
        else {
            events = []
            return
        }
        events = decoded.sorted { $0.date < $1.date }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(events) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}
