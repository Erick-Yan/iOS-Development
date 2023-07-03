/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the list of landmarks.
*/

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData()) // Add model object to env to make it available to all subviews.
    }
}
