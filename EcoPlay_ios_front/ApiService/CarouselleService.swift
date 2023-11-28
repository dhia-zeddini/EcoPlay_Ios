import Foundation
import Combine

struct CarouselleService {
    private let baseURL = URL(string: "https://ecoplay-api.onrender.com/")!
    
    func getAllProducts() -> AnyPublisher<[ProductModel], Error> {
        return URLSession.shared.dataTaskPublisher(for: baseURL.appendingPathComponent("products/getall"))
            .map(\.data)
            .decode(type: [ProductModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // Make sure to receive on the main thread if you're updating UI
            .eraseToAnyPublisher()
    }
}
