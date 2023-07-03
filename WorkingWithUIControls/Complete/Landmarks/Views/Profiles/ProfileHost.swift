/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that hosts the profile viewer and editor.
*/

import SwiftUI

struct ProfileHost: View {
    /// Environment property enables access to storage values which you can read or write in editMode.
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) { /// .cancel modifier prevents the real profile from updating.
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }

            if editMode?.wrappedValue == .inactive { /// Regular summary mode.
                ProfileSummary(profile: modelData.profile)
            } else { /// Edit Mode.
                ProfileEditor(profile: $draftProfile) /// Pass the profile binding.
                    .onAppear {
                        draftProfile = modelData.profile /// draftProfile appears as the modelData profile.
                    }
                    .onDisappear {
                        modelData.profile = draftProfile /// Upon clicking on Done in the profile editor, the modelData profile updates to whatever the draftProfile becomes.
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData()) /// Add environment object attribute to provide profile data to ProfileSummary.
    }
}
