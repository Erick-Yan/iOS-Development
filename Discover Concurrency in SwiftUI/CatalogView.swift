struct CatalogView: View {
    @StateObject private var photos = Photos()

    var body: some View {
        NavigationView {
            List {
                ForEach(photos.items) { item in
                    PhotoView(photo: item)
                        .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Catalog")
            .listStyle(.plain)
            .refreshable {
                await photos.updateItems()
            }
        }
        /// Modifier allows us to wait for the photos state object to update before rendering the NavigationView.
        /// task lifecycle ends when view lifecycle ends.
        .task { 
            await photos.updateItems()
        }
    }
}