//
//  ProfileViewModel.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 28/11/2023.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published  var firstName = ""
    @Published  var lastName = ""
    @Published  var email = ""
    @Published  var phoneNumber = ""
    
    @Published var userModel = UserModel(_id: "", firstName: "", lastName: "", email: "", phoneNumber: "", password: "", avatar: "", points: 0, score: 0, level: 0, goldMedal: 0, silverMedal: 0, bronzeMedal: 0, owned: [""], etatDelete: false, createdAt: "", updatedAt: "", __v: 0)
    @Published var isLoading = false

    private var cancellables: Set<AnyCancellable> = []
    private let apiService = UserService()  

    func fetchUserProfile(userToken: String) {
        isLoading = true
        apiService.getUserProfile(userToken: userToken)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching user profile: \(error.localizedDescription)")
                case .finished:
                    break
                }
                self.isLoading = false
            }, receiveValue: { user in
                self.userModel = user
                self.firstName=user.firstName
                self.lastName=user.lastName
                self.email=user.email
                self.phoneNumber=user.phoneNumber
                
                print(user)
            })
            .store(in: &cancellables)
    }
}
