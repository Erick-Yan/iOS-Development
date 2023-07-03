struct SavePhotoButton: View {
    var photo: SpacePhoto
    @State private var isSaving = false

    var body: some View {
        Button {
            Task {
                isSaving = true
                await photo.save() /// Asynchronously save photo in background.
                isSaving = false
            }
        } label: {
            Text("Save")
                .opacity(isSaving ? 0 : 1)
                .overlay {
                    if isSaving {
                        ProgressView() /// Placeholder when saving (checking the state var while doing so).
                    }
                }
        }
        .disabled(isSaving) /// Disable button while saving is in-progress.
        .buttonStyle(.bordered)
    }
}