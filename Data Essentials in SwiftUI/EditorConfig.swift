/// Encapsulate all related properties under one struct.
struct EditorConfig {
    var isEditorPresented = false
    var note = ""
    var progress: Double = 0
    mutating func present(initialProgress: Double) {
        progress = initialProgress
        note = ""
        isEditorPresented = true
    }
}
struct BookView: View {
    @State private var editorConfig = EditorConfig()
    func presentEditor() { editorConfig.present(…) }
    var body: some View {
        …
        Button(action: presentEditor) { … }
        …
    }
}
struct ProgressEditor: View {
    /// ProgressEditor relies on the editorConfig source of truth provided by BookView (indicated by @State).
    /// To enable read/write access to that source of truth, use @Binding wrapper so any changes to editorConfig 
    /// in ProgressEditor will be reflected in BookView on re-render.
    @Binding var editorConfig: EditorConfig
    …
        TextEditor($editorConfig.note) /// We create a new Binding using the $ on the existing Binding above.
    …
}