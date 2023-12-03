import Foundation

struct AddToCartResponse: Codable {
    let status: String
    // Add other properties based on your API response
}

struct CalculateCartTotalResponse: Codable {
    let total: Double
    // Add other properties based on your API response
}

struct PaymentIntentResponse: Codable {
    let clientSecret: String
    // Add other properties based on your API response
}

struct ResponseMessage: Codable {
    let message: String
    // Add other properties based on your API response
}

