//
//  UserService.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 27/11/2023.
//

import Foundation

import Combine

struct UserService {
     func login(_ credentials: UserCredentials) -> AnyPublisher<LoginResponse, Error> {
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
    
    
    func register(_ registerRequestModel: RegisterRequestModel) -> AnyPublisher<RegisterResponse, Error> {
       let url = URL(string: "https://ecoplay-api.onrender.com/registration")!
       
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")

       let encoder = JSONEncoder()
       request.httpBody = try? encoder.encode(registerRequestModel)

       return URLSession.shared.dataTaskPublisher(for: request)
           .map(\.data)
           .decode(type: RegisterResponse.self, decoder: JSONDecoder())
           .eraseToAnyPublisher()
   }
}
