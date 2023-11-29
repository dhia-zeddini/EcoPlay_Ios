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
    
    
        func getUserProfile(userToken: String) -> AnyPublisher<UserModel, Error> {
            
            let userProfileURL = URL(string: "https://ecoplay-api.onrender.com/user/profile")!

            var request = URLRequest(url: userProfileURL)
            request.httpMethod = "GET"
            
            request.setValue("Bearer \(userToken)", forHTTPHeaderField: "token")

            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return try JSONDecoder().decode(UserModel.self, from: data)
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    
    
    func editAccount(_ registerRequestModel: RegisterRequestModel,userToken: String) -> AnyPublisher<UpdateAccountResponse, Error> {
       let url = URL(string: "https://ecoplay-api.onrender.com/user")!
       
       var request = URLRequest(url: url)
       request.httpMethod = "PUT"
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "token")

       let encoder = JSONEncoder()
       request.httpBody = try? encoder.encode(registerRequestModel)

       return URLSession.shared.dataTaskPublisher(for: request)
           .map(\.data)
           .decode(type: UpdateAccountResponse.self, decoder: JSONDecoder())
           .eraseToAnyPublisher()
   }
}
