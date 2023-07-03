/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that shows a badge for hiking.
*/

import SwiftUI

struct HikeBadge: View {
    var name: String

    var body: some View {
        VStack(alignment: .center) {
            /// Shrink badge frame, scale the badge down, then shrink the frame again.
            Badge()
                .frame(width: 300, height: 300)
                .scaleEffect(1.0 / 3.0)
                .frame(width: 100, height: 100)
            Text(name)
                .font(.caption)
                .accessibilityLabel("Badge for \(name).") /// makes meaning of badge clearer to users.
        }
    }
}

struct HikeBadge_Previews: PreviewProvider {
    static var previews: some View {
        HikeBadge(name: "Preview Testing")
    }
}
