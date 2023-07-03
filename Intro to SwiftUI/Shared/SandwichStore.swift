import Foundation

class SandwichStore: ObservableObject { // Add ObservableObject protocol to tell SwiftUI when object changes.
    /// @Published marks any properties you want SwiftUI to observe.
    @Published var sandwiches: [Sandwich]

    init(sandwiches: [Sandwich] = []) {
        self.sandwiches = sandwiches
    }
}

let testStore = SandwichStore(sandwiches: testData)