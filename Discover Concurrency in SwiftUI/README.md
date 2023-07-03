## Discover Concurrency in SwiftUI
### 1. Observable Object Update Process.
- When updating our Observable Object items under a `@Published` property, it will trigger an objectWillChange event which is captured by SwiftUI.
- SwiftUI sees the objectWillChange and takes a snapshot of the updated items.
- During the next tick (update/re-render instance), SwiftUI will compare the snapshot with the original items and update the views accordingly.
- We can leverage `await` to ensure the update occurs, the snapshot is taken, all before the main actor arrives at the next tick.