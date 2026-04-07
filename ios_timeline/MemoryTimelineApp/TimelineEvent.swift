import Foundation

struct TimelineEvent: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var date: Date
    /// Optional image stored as Base64-encoded JPEG data.
    var imageBase64: String?

    init(id: UUID = UUID(), title: String, date: Date, imageBase64: String? = nil) {
        self.id = id
        self.title = title
        self.date = date
        self.imageBase64 = imageBase64
    }
}
