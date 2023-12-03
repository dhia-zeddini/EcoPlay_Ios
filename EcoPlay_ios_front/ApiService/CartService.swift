import Foundation
import Combine

struct CartService {
    private let baseURL = URL(string: "http://192.168.87.207:8088/")!

    func getProductsInCart(cartId: String) -> AnyPublisher<[ProductModel], Error> {
        let url = baseURL.appendingPathComponent("carts/get")
        let request = createRequest(url: url, method: "POST", body: ["cartId": cartId])
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [ProductModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    func getCart(cartId: String) -> AnyPublisher<[ProductModel], Error> {
        let url = baseURL.appendingPathComponent("carts/get")
        let request = createRequest(url: url, method: "POST", body: ["cartId": cartId])
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [ProductModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func getAllCarts() -> AnyPublisher<[CartModel], Error> {
        let url = baseURL.appendingPathComponent("carts/getall")
        let request = createRequest(url: url, method: "GET", body: nil)
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [CartModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    func addToCart(productId: String, cartId: String) -> AnyPublisher<AddToCartResponse, Error> {
        let url = baseURL.appendingPathComponent("carts/adPtC")
        let request = createRequest(url: url, method: "PUT", body: ["productId": productId, "cartId": cartId])

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .handleEvents(receiveOutput: { data in
                print(String(data: data, encoding: .utf8) ?? "Invalid data")
            })
            .decode(type: AddToCartResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func calculateCartTotal(cartId: String) -> AnyPublisher<CalculateCartTotalResponse, Error> {
        let url = baseURL.appendingPathComponent("carts/total")
        let request = createRequest(url: url, method: "POST", body: ["cartId": cartId])
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: CalculateCartTotalResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func createPaymentIntent(totalC: Int) -> AnyPublisher<PaymentIntentResponse, Error> {
        let url = baseURL.appendingPathComponent("carts/pay")
        let request = createRequest(url: url, method: "POST", body: ["totalC": totalC])
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: PaymentIntentResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func deleteProductFromCart(productId: String, cartId: String) -> AnyPublisher<ResponseMessage, Error> {
        let url = baseURL.appendingPathComponent("carts/rmPtc")
        let request = createRequest(url: url, method: "DELETE", body: ["productId": productId, "cartId": cartId])
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: ResponseMessage.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func createRequest(url: URL, method: String, body: [String: Any]?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}
