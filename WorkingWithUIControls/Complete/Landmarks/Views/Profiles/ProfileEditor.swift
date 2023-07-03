/*
See LICENSE folder for this sample’s licensing information.

Abstract:
An editable profile view.
*/

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile /// Create a binding to profile to enable edits to its values.

    /// Below is a Date Range Selector.
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return min...max
    }

    var body: some View {
        List {
            HStack {
                Text("Username").bold()
                Divider()
                TextField("Username", text: $profile.username) /// Create a binding to the profile username string so the user can update the profile var appropriately.
            }

            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Notifications").bold()
            }

            VStack(alignment: .leading, spacing: 20) {
                Text("Seasonal Photo").bold()

                /// Picker enables users to select an option that can update a specific binding/state var.
                Picker("Seasonal Photo", selection: $profile.seasonalPhoto) {
                    ForEach(Profile.Season.allCases) { season in
                        Text(season.rawValue).tag(season)
                    }
                }
                .pickerStyle(.segmented)
            }

            DatePicker(selection: $profile.goalDate, in: dateRange, displayedComponents: .date) {
                Text("Goal Date").bold()
            }
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
