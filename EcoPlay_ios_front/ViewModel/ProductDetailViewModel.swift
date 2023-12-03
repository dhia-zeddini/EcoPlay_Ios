import Foundation
import Combine

class ProductDetailViewModel: ObservableObject {
    @Published var product: ProductModel
    private var cancellables: Set<AnyCancellable> = []
    @Published var cartId: String? // Add cartId property

    init(product: ProductModel) {
        self.product = product
    }

    // Add any additional methods or properties you may need for data manipulation or fetching

    // Example method to update product details
    func updateProductDetails() {
        // Implement logic to update product details here
        // This could involve making a network request or fetching data from another source
    }
    func addToCart() {
           guard let cartId = cartId else {
               print("Error: Cart ID is missing")
               return
           }

           // You can implement the logic to add the product to the specified cart here
           // This could involve making a network request or updating a local cart object
           print("Product added to cart with ID: \(cartId)")
       }
}
