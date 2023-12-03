import Foundation


struct ProductModel: Identifiable, Codable {
    var id: String
    var nameP: String
    var descriptionP: String
    var image: String
    var priceP: String  // Change the data type to String if the JSON provides price as a String
    var typeP: String
    var createdAt: String
    var updatedAt: String
    var __v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nameP, descriptionP, priceP, typeP, image, createdAt, updatedAt, __v
    }
}
