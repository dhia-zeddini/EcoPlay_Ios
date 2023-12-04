import Foundation
import Combine

class CartViewModel: ObservableObject {
    @Published var carts: [ProductModel] = []
    @Published var isCartLoading = false
    @Published var totalAmount: Double = 0.0

    private let cartService = CartService()
    private var cancellables: Set<AnyCancellable> = []

    func fetchCartWithID() {
        isCartLoading = true

        let cartId = "654567418bfbbff40a384edd"

        cartService.getCart(cartId: cartId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isCartLoading = false
                case .failure(let error):
                    print("Error: \(error)")
                    self.isCartLoading = false
                }
            }, receiveValue: { carts in
                self.carts = carts
                self.totalAmount = carts.reduce(0) { $0 + (Double($1.priceP) ?? 0) }
           
            })
            .store(in: &cancellables)
    }
    func deleteProductFromCart(productId: String, cartId: String) {
        cartService.deleteProductFromCart(productId: productId, cartId: cartId)
            .sink(receiveCompletion: { completion in
                // Add debug statement here
                print(completion)
            }, receiveValue: { response in
                // Add debug statement here
                print(response)
                // Refresh cart items here if needed
            })
            .store(in: &cancellables)
    }
    
    func addProductToCart(productId: String, cartId: String, completion: @escaping (Bool, String) -> Void) {
        cartService.addToCart(productId: productId, cartId: cartId)
            .sink(receiveCompletion: { completionStatus in
                switch completionStatus {
                case .finished:
                    // Handle normally if no errors
                    break
                case .failure(let error):
                    // Handle error scenario
                    print("Error adding product to cart: \(error)")
                    completion(false, "Failed to add product")
                }
            }, receiveValue: { response in
                // Here, inspect the response to determine the correct message
                // Example:
                if response.message.contains("already in cart") {
                    completion(false, "Product already in cart")
                } else {
                    completion(true, "Product added successfully")
                }
            })
            .store(in: &cancellables)
    }
    func createPaymentIntent(totalC: Int, completion: @escaping (String) -> Void) {
           // Implement the network call to your backend to create a payment intent
           // The backend should return the client secret of the payment intent
           // Call completion with the client secret
       }

}
