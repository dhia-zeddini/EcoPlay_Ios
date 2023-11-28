import Foundation

struct ProductModel: Identifiable, Codable {
    var id: String
    var nameP: String
    var descriptionP: String
    var priceP: String  // Change the data type to String if the JSON provides price as a String
    var typeP: String
    var image: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nameP, descriptionP, priceP, typeP, image
    }
}

