import Foundation
import Combine

class CarouselleViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    private var cancellables: Set<AnyCancellable> = []
    private let carouselleService: CarouselleService

    init(carouselleService: CarouselleService = CarouselleService()) {
        self.carouselleService = carouselleService
    }

    func fetchProducts() {
        carouselleService.getAllProducts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break // Do nothing for successful completion
                case .failure(let error):
                    print("Error fetching products: \(error)")
                }
            }, receiveValue: { [weak self] products in
                DispatchQueue.main.async {
                    self?.products = products
                }
            })
            .store(in: &cancellables)
    }
}
