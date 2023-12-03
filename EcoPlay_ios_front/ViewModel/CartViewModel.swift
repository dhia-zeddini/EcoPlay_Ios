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


}
