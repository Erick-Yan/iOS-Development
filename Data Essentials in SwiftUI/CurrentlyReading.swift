/// The current reading progress for a specific book.
class CurrentlyReading: ObservableObject {
    let book: Book
    /// @Published works with ObservableObject, publishes everytime the value changes in willSet.
    @Published var progress: ReadingProgress

    // …
}

struct ReadingProgress {
    struct Entry : Identifiable {
        let id: UUID
        let progress: Double
        let time: Date
        let note: String?
    }

    var entries: [Entry]
}