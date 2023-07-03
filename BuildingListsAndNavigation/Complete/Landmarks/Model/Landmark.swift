/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A representation of a single landmark.
*/

import Foundation
import SwiftUI
import CoreLocation

/*
    Codable enables efficient and easy encoding/decoding with data that the struct is interacting with.
    Ex. When creating a struct from a JSON file.
*/
struct Landmark: Hashable, Codable, Identifiable {
    var id: Int /// Required for Identifiable protocol.
    var name: String
    var park: String
    var state: String
    var description: String

    private var imageName: String
    var image: Image {
        Image(imageName)
    }

    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
