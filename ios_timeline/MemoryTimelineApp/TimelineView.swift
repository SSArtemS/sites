import SwiftUI
import UIKit

struct TimelineView: View {
    @EnvironmentObject private var store: EventsStore

    private let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "uk_UA")
        formatter.dateFormat = "LLLL yyyy"
        return formatter
    }()

    var body: some View {
        NavigationStack {
            ScrollView {
                if store.events.isEmpty {
                    ContentUnavailableView(
                        "Ще немає подій",
                        systemImage: "clock.arrow.circlepath",
                        description: Text("Додай першу подію у вкладці 'Додати'.")
                    )
                    .padding(.top, 80)
                } else {
                    LazyVStack(spacing: 24) {
                        ForEach(store.events) { event in
                            HStack(alignment: .top, spacing: 16) {
                                VStack(spacing: 0) {
                                    Circle()
                                        .fill(Color.purple)
                                        .frame(width: 12, height: 12)
                                    Rectangle()
                                        .fill(Color.purple.opacity(0.35))
                                        .frame(width: 2)
                                }

                                VStack(alignment: .leading, spacing: 10) {
                                    Text(event.title)
                                        .font(.headline)

                                    Text(monthFormatter.string(from: event.date).capitalized)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)

                                    if
                                        let base64 = event.imageBase64,
                                        let data = Data(base64Encoded: base64),
                                        let uiImage = UIImage(data: data)
                                    {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 220)
                                            .frame(maxWidth: .infinity)
                                            .clipped()
                                            .clipShape(RoundedRectangle(cornerRadius: 14))
                                    }
                                }
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color(.systemBackground))
                                        .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
                                )
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .background(Color(.systemGray6))
            .navigationTitle("Таймлайн")
        }
    }
}
