//
//  ContentView.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 25/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showSignup: Bool = false
    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()
    @ObservedObject var registerViewModel: RegisterViewModel = RegisterViewModel()

    var body: some View{
        NavigationStack{
            if showSignup {
                        RegisterView(viewModel: registerViewModel, showSignup: $showSignup)
                            .navigationDestination(isPresented: $registerViewModel.showSignup) {
                                LoginView(viewModel: loginViewModel, showSignup: $showSignup)
                            }
                    } else {
                        LoginView(viewModel: loginViewModel, showSignup: $showSignup)
                    }
       
        }
      
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


