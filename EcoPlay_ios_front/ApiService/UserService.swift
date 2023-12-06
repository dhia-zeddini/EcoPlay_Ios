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
        let url = URL(string: "http://localhost:9001/login")!
        
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
    
    
    func register(_ registerRequestModel: RegisterRequestModel, boundary: String) -> AnyPublisher<RegisterResponse, Error> {
       let url = URL(string: "http://localhost:9001/registration")!
       
       var request = URLRequest(url: url)
        request.httpMethod = "POST"
          request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

          var body = Data()

          // Add text fields
          body.append("--\(boundary)\r\n")
          body.append("Content-Disposition: form-data; name=\"firstName\"\r\n\r\n")
          body.append("\(registerRequestModel.firstName)\r\n")
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"lastName\"\r\n\r\n")
        body.append("\(registerRequestModel.lastName)\r\n")
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"email\"\r\n\r\n")
        body.append("\(registerRequestModel.email)\r\n")
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"phoneNumber\"\r\n\r\n")
        body.append("\(registerRequestModel.phoneNumber)\r\n")
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"password\"\r\n\r\n")
        body.append("\(registerRequestModel.password)\r\n")

          // Repeat for other fields...

          // Add the image data
          if let imageData = registerRequestModel.avatar {
              body.append("--\(boundary)\r\n")
              body.append("Content-Disposition: form-data; name=\"avatar\"; filename=\"avatar.jpg\"\r\n")
              body.append("Content-Type: image/jpeg\r\n\r\n")
              body.append(imageData)
              body.append("\r\n")
          }

          body.append("--\(boundary)--\r\n")
          request.httpBody = body

       return URLSession.shared.dataTaskPublisher(for: request)
           .map(\.data)
           .decode(type: RegisterResponse.self, decoder: JSONDecoder())
           .eraseToAnyPublisher()
   }
    
    
        func getUserProfile(userToken: String) -> AnyPublisher<UserModel, Error> {
            
            let userProfileURL = URL(string: "http://localhost:9001/user/profile")!

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
    
    
    func editAccount(_ registerRequestModel: UpdateAccountModel,userToken: String) -> AnyPublisher<UpdateAccountResponse, Error> {
       let url = URL(string: "http://localhost:9001/user")!
       
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
    
    func forgetPwd(_ credentials: UserCredentials) -> AnyPublisher<ForgetPwdResponse, Error> {
       let url = URL(string: "http://localhost:9001/forgetPwd")!
       
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")

       let encoder = JSONEncoder()
       request.httpBody = try? encoder.encode(credentials)

       return URLSession.shared.dataTaskPublisher(for: request)
           .map(\.data)
           .decode(type: ForgetPwdResponse.self, decoder: JSONDecoder())
           .eraseToAnyPublisher()
   }
    
    func otp(_ credentials: UserCredentials,userToken: String) -> AnyPublisher<ForgetPwdResponse, Error> {
       let url = URL(string: "http://localhost:9001/otp")!
       
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "token")
       let encoder = JSONEncoder()
       request.httpBody = try? encoder.encode(credentials)

       return URLSession.shared.dataTaskPublisher(for: request)
           .map(\.data)
           .decode(type: ForgetPwdResponse.self, decoder: JSONDecoder())
           .eraseToAnyPublisher()
   }
    
    func newPwd(_ credentials: UserCredentials,userToken: String) -> AnyPublisher<LoginResponse, Error> {
       let url = URL(string: "http://localhost:9001/newPwd")!
       
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "token")

       let encoder = JSONEncoder()
       request.httpBody = try? encoder.encode(credentials)

       return URLSession.shared.dataTaskPublisher(for: request)
           .map(\.data)
           .decode(type: LoginResponse.self, decoder: JSONDecoder())
           .eraseToAnyPublisher()
   }
}
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
