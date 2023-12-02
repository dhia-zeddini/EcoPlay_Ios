//
//  ResetPwdViewModel.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 2/12/2023.
//

import Foundation

import Combine

class ResetPwdViewModel: ObservableObject {
        @Published var confirmPassword = ""
        @Published var password = ""
        @Published var showingAlert = false
        @Published var errorMessage = ""

        private var cancellables: Set<AnyCancellable> = []
        private let apiService = UserService()

    
    func newPwd(userToken: String) {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            showingAlert = true
            return
        }
         let userCredentials = UserCredentials(data: "", password: password)

         apiService.newPwd(userCredentials, userToken: userToken)
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
                     print(loginResponse.token)
                           } else {
                               self.errorMessage = loginResponse.error
                               self.showingAlert = true
                           }
             })
             .store(in: &cancellables)
     }
 

    func reset() {
        confirmPassword = ""
        password = ""
        showingAlert = false
        errorMessage = ""
    }
}

