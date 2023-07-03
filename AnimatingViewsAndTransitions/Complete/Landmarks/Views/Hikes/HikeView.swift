/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view displaying information about a hike, including an elevation graph.
*/

import SwiftUI

/// Create a static transition property which view's transition modifiers can access.
extension AnyTransition {
    static var moveAndFade: AnyTransition {
        /// Asymmetric enables different behaviors for when view appears and disappears.
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity), /// View slides in/out from same side.
            removal: .scale.combined(with: .opacity)
        )
    }
}

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = false

    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)

                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }

                Spacer()

                Button {
                    /// Both the showDetail button and the HikeDetail view that the button toggles have animated transitions.
                    withAnimation { /// Pass animation duration (withAnimation(.easeInOut(duration: 4))).
                        showDetail.toggle()
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        /// .animation(nil, value: showDetail) add this to prevent rotationEffect from being animated.
                        .scaleEffect(showDetail ? 1.5 : 1) /// Animation modifier to make button larger when graph is visible.
                        .padding()
                }
            }

            if showDetail {
                HikeDetail(hike: hike)
                    .transition(.moveAndFade) /// Transition modifier where graph slides in/out of sight.
            }
        }
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HikeView(hike: ModelData().hikes[0])
                .padding()
            Spacer()
        }
    }
}
