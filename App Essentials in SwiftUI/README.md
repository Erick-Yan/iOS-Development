## 1. App Essentials in SwiftUI
### 1.1 Views, Scenes, and Apps
- Hierarchical: Apps -> Scenes -> Views
- Views can be composed of multiple subviews.
- Scenes can be made up of multiple views.
- Apps can be made up of multiple scenes.
- Apps can provide a shared model for each scene to use but the scene states are independent.
    - Ex. Opening the same app among multiple windows, each showing a different page (scene).
    - We can merge multiple windows into a single window with a tab interface which opens up to each window (scene).
    - We can change individual states of each window (scene) without it affecting other open windows (scenes).
    - `@SceneStorage` property wrapper enables SwiftUI to save and restore a scene state.
```
@main
struct BookClubApp: App {
    @StateObject private var store = ReadingListStore()

    var body: some Scene {
        WindowGroup {
            ReadingListViewer(store: store)
        }
    }
}

struct ReadingListViewer: View {
    @ObservedObject var store: ReadingListStore
    @SceneStorage("selectedItem") private var selectedItem: String?
    
    var selectedID: Binding<UUID?> {
        Binding<UUID?>(
            get: { selectedItem.flatMap { UUID(uuidString: $0) } },
            set: { selectedItem = $0?.uuidString }
        )
    }

    var body: some View {
        NavigationView {
            List(store.books) { book in
                NavigationLink(
                    destination: Text(book.title),
                    tag: book.id,
                    selection: selectedID
                ) {
                    Text(book.title)
                }
            }
            .navigationTitle("Currently Reading")
        }
    }
}

class ReadingListStore: ObservableObject {
    init() {}

    var books = [
        Book(title: "Book #1", author: "Author #1"),
        Book(title: "Book #2", author: "Author #2"),
        Book(title: "Book #3", author: "Author #3")
    ]
}

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
}
```
- Settings scene type: enables the preferences window to become available in the app menu.
```
#if os(macOS)
    Settings {
        BookClubSettingsView()
    }
#endif
```
- Commands modifier: 
```
struct BookCommands: Commands {
    @FocusedBinding(\.selectedBook) private var selectedBook: Book?
    
    var body: some Commands {
        CommandMenu("Book") {
            Section {
                Button("Update Progress...", action: updateProgress)
                    .keyboardShortcut("u")
                Button("Mark Completed", action: markCompleted)
                    .keyboardShortcut("C")
            }
            .disabled(selectedBook == nil)
        }
    }
    
    private func updateProgress() {
        selectedBook?.updateProgress()
    }
    private func markCompleted() {
        selectedBook?.markCompleted()
    }
}
```