//
//  UserService.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 27/11/2023.
//

import Foundation

import Combine

struct UserService {
    static func login(_ credentials: UserCredentials) -> AnyPublisher<LoginResponse, Error> {
        let url = URL(string: "https://ecoplay-api.onrender.com/login")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(credentials)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
