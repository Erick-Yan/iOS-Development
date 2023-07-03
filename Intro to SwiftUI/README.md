## Introduction to Swift Notes
### 1. Views
```
struct SandwichDetail: View {
    let sandwich: Sandwich

    var body: some View {
        Image(sandwich.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
```
- structs that conforms to the view protocol.
- Doesn't inherit stored properties.
- Passed by value.
- Lightweight.
- Views are composed on multiple subviews.

#### 1.1 State Vars, Source of Truth, and Derived Values
```
struct SandwichDetail: View {
    let sandwich: Sandwich
    @State private var zoomed = false

    var body: some View {
        Image(sandwich.imageName)
            .resizable()
            .aspectRatio(contentMode: zoomed ? .fill : .fit)
            .onTapGesture { zoomed.toggle() }
    }
}

struct AspectRatioView: View {
    let contentMode: ContentMode
    var body: some View { ... }
}
```
- aspectRatio makes a view and contains a plain old Swift property called contentMode.
- Every property can be defined as a source of truth (State) or a derived value (contentMode).
