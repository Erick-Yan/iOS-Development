/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that displays a badge.
*/

import SwiftUI

struct Badge: View {
    var badgeSymbols: some View {
        /// Apply rotation across multiple rotated badge symbols for a full circular effect.
        ForEach(0..<8) { index in
            RotatedBadgeSymbol(
                angle: .degrees(Double(index) / Double(8)) * 360.0
            )
        }
        .opacity(0.5)
    }

    var body: some View {
        /// ZStack used to overlay components ontop of one another.
        ZStack {
            BadgeBackground()

            /// Scale the badge symbol accordingly.
            GeometryReader { geometry in
                badgeSymbols
                    .scaleEffect(1.0 / 4.0, anchor: .top)
                    .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
            }
        }
        .scaledToFit()
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}
