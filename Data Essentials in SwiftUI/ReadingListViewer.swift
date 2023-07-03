struct ReadingListViewer: View {
    var body: some View {
        NavigationView {
            ReadingList()
            Placeholder()
        }
    }
}

struct ReadingList: View {
    /// Repeated heap allocation caused by creating a new ReadingListStore object everytime ReadingList body is 
    /// called since view structs don't have a defined lifetime.
    /// Since the object is reset every time, this can cause performance to become slow and expensive and potentially 
    /// introduce data loss.
    @ObservedObject var store = ReadingListStore()
    @StateObject var store = ReadingListStore() /// Solution: instantiate it at the right time.

    var body: some View {
        // ...
    }
}