//
//  RegisterViewModel.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 28/11/2023.
//

import Foundation
import Combine
import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var avatar = UIImage()
    @Published var showSignIn = false
    @Published var showSignup = false
    @Published var showingAlert = false
    @Published var errorMessage = ""
    @Published var userToken: String = ""
    //@Binding var showSignup: Bool
    private var cancellables: Set<AnyCancellable> = []
    private let apiService = UserService()
    
  

     func registerUser() {
         guard password == confirmPassword else {
             errorMessage = "Passwords do not match"
             showingAlert = true
             return
         }
       
         guard let imageData = avatar.jpegData(compressionQuality: 1) else {
                  errorMessage = "Failed to convert image to data"
                  showingAlert = true
                  return
              }
         
         print("img: \(imageData)")
         let registerRequestModel = RegisterRequestModel(
             firstName: firstName,
             lastName: lastName,
             email: email,
             phoneNumber: phoneNumber,
             password: password,
             avatar: imageData
         )
         let boundary = "Boundary-\(UUID().uuidString)"
        apiService.register(registerRequestModel, boundary: boundary)
           // .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.showingAlert = true
                case .finished:
                    break
                }
            }, receiveValue: { RegisterResponse in
                
                print("in status: \(RegisterResponse.status)")
                if RegisterResponse.status {
                    self.showSignIn = true
                    self.reset()
                    print("in reggggg \(self.showSignIn)")//

                } else {
                    self.errorMessage = RegisterResponse.success
                    self.showingAlert = true
                }
            })
            .store(in: &cancellables)
    }
    
    
    func reset() {
        firstName = ""
        lastName = ""
        email = ""
        phoneNumber = ""
        password = ""
        confirmPassword = ""
        avatar = UIImage()
        //showSignIn=false
    }
}
