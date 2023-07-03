struct BookCoverView: View {
    @StateObject var loader = CoverImageLoader()

    var coverName: String
    var size: CGFloat

    var body: some View {
        CoverImage(loader.image, size: size)
            .onAppear { loader.load(coverName) }
    }
}