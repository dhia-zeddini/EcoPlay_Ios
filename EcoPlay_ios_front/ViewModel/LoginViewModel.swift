//
//  LoginViewModel.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 27/11/2023.
//

import Foundation

import Combine

class LoginViewModel: ObservableObject {
        @Published var data = ""
        @Published var password = ""
        @Published var isLoggedIn = false
        @Published var showingAlert = false
        @Published var errorMessage = ""
        @Published var userToken: String = ""

        private var cancellables: Set<AnyCancellable> = []
        private let apiService = UserService()

    
    func loginUser() {
         let userCredentials = UserCredentials(data: data, password: password)

         apiService.login(userCredentials)
             .receive(on: DispatchQueue.main)
             .sink(receiveCompletion: { completion in
                 switch completion {
                 case .failure(let error):
                     self.errorMessage = error.localizedDescription
                     self.showingAlert = true
                 case .finished:
                     break
                 }
             }, receiveValue: { loginResponse in
                 if loginResponse.status {
                               self.isLoggedIn = true
                               self.userToken = loginResponse.token
                               UserDefaults.standard.set(loginResponse.token, forKey: "token")
                           } else {
                               self.errorMessage = loginResponse.error
                               self.showingAlert = true
                           }
             })
             .store(in: &cancellables)
     }
 

    func reset() {
        data = ""
        password = ""
        showingAlert = false
        errorMessage = ""
    }
}
