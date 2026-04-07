# iOS Timeline App (SwiftUI)

Готовий приклад iOS-додатку з 2 вкладками:

1. **Додати** — створення події (назва, дата, фото опціонально).
2. **Події** — вертикальний таймлайн із картками подій.

## Файли

- `MemoryTimelineApp.swift` — точка входу.
- `ContentView.swift` — `TabView` із двома вкладками.
- `AddEventView.swift` — форма додавання події + `PhotosPicker`.
- `TimelineView.swift` — вертикальний таймлайн.
- `EventsStore.swift` — збереження/завантаження подій у `UserDefaults`.
- `TimelineEvent.swift` — модель події.

## Як запустити

1. Створи в Xcode новий **iOS App** (SwiftUI, Swift).
2. Замінити згенеровані файли на файли з папки `MemoryTimelineApp`.
3. Мінімальна версія iOS: **16.0+** (через `PhotosPicker`).
4. Запусти на симуляторі або девайсі.

## Нотатки

- Фото зберігається як Base64 у `UserDefaults` для простоти.
- Для production краще перейти на зберігання файлів у Documents/Core Data/SwiftData.
