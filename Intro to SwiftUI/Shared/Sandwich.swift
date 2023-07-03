/// Model File for Sandwiches.
import Foundation

struct Sandwich: Identifiable { // Add Identifiable to make enable the object in a list.
    var id = UUID()
    var name: String
    var ingredientCount: Int
    var isSpicy: Bool = false

    var imageName: String {return name}
    var thumbnailName: String {return name + "Thumb"}
}

let testData = [
    Sandwich(name: "Club", ingredientCount: 4, isSpicy: false)
]