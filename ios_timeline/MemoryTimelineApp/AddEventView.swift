import PhotosUI
import SwiftUI
import UIKit

struct AddEventView: View {
    @EnvironmentObject private var store: EventsStore

    @State private var title: String = ""
    @State private var date: Date = .now
    @State private var selectedItem: PhotosPickerItem?
    @State private var imageData: Data?

    var body: some View {
        NavigationStack {
            Form {
                Section("Нова подія") {
                    TextField("Назва події", text: $title)
                    DatePicker("Дата", selection: $date, displayedComponents: .date)
                }

                Section("Фото (необов'язково)") {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Label("Обрати фото", systemImage: "photo")
                    }

                    if let imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }

                Section {
                    Button("Додати") {
                        store.addEvent(
                            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
                            date: date,
                            imageBase64: imageData?.base64EncodedString()
                        )
                        clearForm()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .navigationTitle("Додати")
            .onChange(of: selectedItem) { _, newItem in
                guard let newItem else { return }
                Task {
                    imageData = try? await newItem.loadTransferable(type: Data.self)
                }
            }
        }
    }

    private func clearForm() {
        title = ""
        date = .now
        selectedItem = nil
        imageData = nil
    }
}
