import SwiftUI

struct ContentView: View {
    @ObservedObject var store: SandwichStore

    var body: some View {
        /// Enable navigation from the current page.
        NavigationView {
            List {
                /// Dynamic Content.
                ForEach(store.sandwiches) { sandwich in
                    SandwichCell(sandwich: sandwich)
                }
                .onMove(perform: moveSandwiches)
                .onDelete(perform: deleteSandwiches)
                /// Static Content.
                HStack {
                    /// Spacers center text in HStack.
                    Spacer()
                    Text("\(store.sandwiches.count) Sandwiches")
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .navigationTitle("Sandwiches")
            /// Add an edit button using the toolbar modifier when in iOS.
            .toolbar {
                #if os(iOS)
                EditButton()
                #endif
                Button("Add", action: makeSandwich)
            }

            /// Placeholder text that appears on iPad but not iPhone.
            Text("Select a sandwich")
                .font(.largeTitle)
        }
    }

    func makeSandwich() {
        withAnimation {
            store.sandwiches.append(Sandwich(name: "Patty melt", ingredientCount: 3))
        }
    }

    func moveSandwiches(from:IndexSet, to: Int) {
        withAnimation {
            store.sandwiches.move(fromOffsets: from, toOffset: to)
        }
    }

    func deleteSandwiches(offsets:IndexSet) {
        withAnimation {
            store.sandwiches.remove(atOffsets: offsets)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(store: testStore)
            ContentView(store: testStore)
                // environment modifiers promotes cascading changes all views within the ContentView.
                .environment(\.sizeCategory, .extraExtraExtraLarge)
            ContentView(store: testStore)
                .preferedColorScheme(.dark)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
            ContentView(store: testStore)
                .preferedColorScheme(.dark)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}

struct SandwichCell: View {
    var sandwich: Sandwich

    var body: some View {
        NavigationLink(detination: SandwichDetail(sandwich: sandwich)) {
            Image(sandwich.thumbnailName)
                .cornerRadius(8)

            /// Command click on view - Show properties - change alignment
            VStack(alignment: .leading) { 
                Text(sandwich.name)
                /// Add text snippet and drag onto canvas.
                Text("\(sandwich.ingredientCount) ingredients") 
                    /// Added by right clicking on text in canvas and adding new property in inspector.
                    /// Below is called a modifier.
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }   
        }
    }
}