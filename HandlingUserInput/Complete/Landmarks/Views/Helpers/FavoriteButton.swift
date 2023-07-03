/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A button that acts as a favorites indicator.
*/

import SwiftUI

struct FavoriteButton: View {
    /// @Binding is a wrapper than enables properties like isSet to be defined in 1 view and modified in another view.
    @Binding var isSet: Bool

    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
