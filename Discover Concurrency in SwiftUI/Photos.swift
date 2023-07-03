/// An observable object representing a random list of space photos.
@MainActor /// Add MainActor wrapper to ensure the ObservableObject is updated correctly each time.
class Photos: ObservableObject {
    @Published private(set) var items: [SpacePhoto] = []

    /// Updates `items` to a new, random list of `SpacePhoto`.
    func updateItems() async {
        let fetched = await fetchPhotos()
        items = fetched
    }

    /// Fetches a new, random list of `SpacePhoto`.
    func fetchPhotos() async -> [SpacePhoto] {
        var downloaded: [SpacePhoto] = []
        for date in randomPhotoDates() {
            let url = SpacePhoto.requestFor(date: date)
            /// Only append to downloaded if fetchPhoto returns SpacePhoto.
            if let photo = await fetchPhoto(from: url) {
                downloaded.append(photo)
            }
        }
        return downloaded
    }

    /// Fetches a `SpacePhoto` from the given `URL`.
    func fetchPhoto(from url: URL) async -> SpacePhoto? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try SpacePhoto(data: data)
        } catch {
            return nil
        }
    }
}