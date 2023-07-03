struct BookView: View {
    @ObservedObject var currentlyReading: CurrentlyReading

    var body: some View {
        VStack {
            BookCard(
                currentlyReading: currentlyReading)

            HStack {
                Button(action: presentEditor) { /* … */ }
                    .disabled(currentlyReading.isFinished)

                Toggle(
                    isOn: $currentlyReading.isFinished
                ) {
                    Label(
                        "I'm Done",
                        systemImage: "checkmark.circle.fill")
                }
            }
            //…
        }
    }
}