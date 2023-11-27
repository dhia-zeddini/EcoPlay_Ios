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
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    private var cancellables: Set<AnyCancellable> = []

    func login() {
        isLoading = true

        let credentials = UserCredentials(data: data, password: password)
        UserService.login(credentials)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.isLoading = false
                        self.errorMessage = error.localizedDescription
                        print("Login failed: \(error.localizedDescription)")
                    }
                },
                receiveValue: { response in
                    self.isLoading = false
                    self.errorMessage = response.error.isEmpty ? nil : response.error
                    // Handle successful login, e.g., store the token in a secure place
                    if response.status {
                        print("Login successful. Token: \(response.token)")
                    }
                }
            )
            .store(in: &cancellables)
    }



    func reset() {
        data = ""
        password = ""
        isLoading = false
        errorMessage = nil
    }
}
