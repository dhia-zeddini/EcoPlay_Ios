import Foundation
import Combine

class ProductDetailViewModel: ObservableObject {
    @Published var product: ProductModel
    private var cancellables: Set<AnyCancellable> = []

    init(product: ProductModel) {
        self.product = product
    }

    // Add any additional methods or properties you may need for data manipulation or fetching

    // Example method to update product details
    func updateProductDetails() {
        // Implement logic to update product details here
        // This could involve making a network request or fetching data from another source
    }
}
