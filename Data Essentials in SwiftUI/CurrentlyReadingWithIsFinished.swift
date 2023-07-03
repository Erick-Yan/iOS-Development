class CurrentlyReading: ObservableObject {
    let book: Book
    @Published var progress = ReadingProgress()
    @Published var isFinished = false

    var currentProgress: Double {
        isFinished ? 1.0 : progress.progress
    }
}