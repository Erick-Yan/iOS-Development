struct ReadingListViewer: View {
    @SceneStorage("selection") var selection: String? /// New source of truth and must follow the data type we want to save in ReadingList.

    var body: some View {
        NavigationView {
            ReadingList(selection: $selection)
            BookDetailPlaceholder()
        }
    }
}