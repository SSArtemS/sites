import SwiftUI

struct ContentView: View {
    @StateObject private var store = EventsStore()

    var body: some View {
        TabView {
            AddEventView()
                .tabItem {
                    Label("Додати", systemImage: "plus.circle")
                }

            TimelineView()
                .tabItem {
                    Label("Події", systemImage: "list.bullet.rectangle.portrait")
                }
        }
        .environmentObject(store)
    }
}

#Preview {
    ContentView()
}
