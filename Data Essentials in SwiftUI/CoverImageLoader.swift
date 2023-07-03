class CoverImageLoader: ObservableObject {
    @Published public private(set) var image: Image? = nil

    func load(_ name: String) {
        // …
    }

    func cancel() {
        // …
    }

    deinit {
        cancel()
    }
}