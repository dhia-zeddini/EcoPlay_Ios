//
//  OTPViewModel.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 29/11/2023.
//

import Foundation
import Combine

class OTPViewModel: ObservableObject {
        @Published var otpText = ""
        @Published var isLoggedIn = false
        @Published var showingAlert = false
        @Published var errorMessage = ""
        @Published var userToken: String = ""
        @Published var showOtpView = false
        private var cancellables: Set<AnyCancellable> = []
        private let apiService = UserService()

    
    func otp(userToken: String) {
         let userCredentials = UserCredentials(data: otpText, password: "")

         apiService.otp(userCredentials,userToken: userToken)
             .receive(on: DispatchQueue.main)
             .sink(receiveCompletion: { completion in
                 switch completion {
                 case .failure(let error):
                     self.errorMessage = error.localizedDescription
                     print("forget: \(error.localizedDescription)")
                     self.showingAlert = true
                 case .finished:
                     break
                 }
             }, receiveValue: { loginResponse in
                 print("forget: \(loginResponse)")
                 if loginResponse.status {
                               self.isLoggedIn = true
                               self.userToken = loginResponse.token
                               UserDefaults.standard.set(loginResponse.token, forKey: "token")
                                self.showOtpView = true
                     self.reset()
                           } else {
                               self.errorMessage = loginResponse.token
                               self.showingAlert = true
                           }
             })
             .store(in: &cancellables)
     }
 

    func reset() {
        otpText = ""
        showingAlert = false
        errorMessage = ""
    }
}
