import Foundation

struct CartModel: Identifiable, Codable {
    var id: String
    var products: [ProductModel]
    var totalC: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case products
        case totalC
    }
}
