struct BookClubSettings: View {
    /// Allows us to save the app state for certain view properties, which we can update using binding $.
    @AppStorage("updateArtwork") private var updateArtwork = true
    @AppStorage("syncProgress") private var syncProgress = true

    var body: some View {
        Form {
            Toggle(isOn: $updateArtwork) {
                //...
            }

            Toggle(isOn: $syncProgress) {
                //...
            }
        }
    }
}