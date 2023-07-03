import SwiftUI

/// @main tells SwiftUI this is starting point.
@main
struct SandwichesApp: App {
    /// StateObject automatically observes object to update our view when it changes.
    @StateObject private var store = SandwichStore()

    var body: some Scene {
        /// WindowGroup lets us specify what view we want to use for all windows in our app.
        WindowGroup {
            ContentView(store: store)
        }
    }
}