import Foundation
import Combine

struct CarouselleService {
    private let baseURL = URL(string: "http://192.168.87.207:8088/")!
    
    func getAllProducts() -> AnyPublisher<[ProductModel], Error> {
        URLSession.shared.dataTaskPublisher(for: baseURL.appendingPathComponent("products/getall"))
            .map(\.data)
            .decode(type: [ProductModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
