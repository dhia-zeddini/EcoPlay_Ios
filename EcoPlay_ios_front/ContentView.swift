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
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()

    var body: some View{
        NavigationStack{
            LoginView(viewModel: viewModel,showSignup: $showSignup).navigationDestination(isPresented: $showSignup){
                RegisterView(showSignup: $showSignup)
            }
       
        }
      
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
