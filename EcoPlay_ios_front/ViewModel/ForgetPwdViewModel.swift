//
//  ForgetPwdViewModel.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 29/11/2023.
//

import Foundation

import Combine

class ForgetPwdViewModel: ObservableObject {
        @Published var data = ""
        @Published var password = ""
        @Published var isLoggedIn = false
        @Published var showingAlert = false
        @Published var errorMessage = ""
        @Published var userToken: String = ""
        @Published var showOtpView = false
        private var cancellables: Set<AnyCancellable> = []
        private let apiService = UserService()

    
    func forgetPwd() {
         let userCredentials = UserCredentials(data: data, password: "")

         apiService.forgetPwd(userCredentials)
            .receive(on: DispatchQueue.main)
             .sink(receiveCompletion: { completion in
                 switch completion {
                 case .failure(let error):
                     self.errorMessage = "User dose not exist"
                     print("forget: \(error.localizedDescription)")
                     self.showingAlert = true
                 case .finished:
                     break
                 }
             }, receiveValue: { loginResponse in
                 print("forget: \(loginResponse)")
                 if loginResponse.status {
                     self.reset()
                               self.isLoggedIn = true
                               self.userToken = loginResponse.token
                               UserDefaults.standard.set(loginResponse.token, forKey: "token")
                                self.showOtpView = true
                     
                           } else {
                               self.errorMessage = "User dose not exist"
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
