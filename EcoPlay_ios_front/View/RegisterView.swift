//
//  RegisterView.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 26/11/2023.
//

import SwiftUI

struct RegisterView: View {
  
    @Binding var showSignup: Bool
    @ObservedObject var viewModel: RegisterViewModel
    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()

    init(viewModel: RegisterViewModel, showSignup: Binding<Bool>) {
         self.viewModel = viewModel
         self._showSignup = showSignup
     }
    var body: some View {
        ZStack {
           
            Image("eco_play_background") // Make sure to replace "eco_play_background" with your actual image name
                .resizable()
                .edgesIgnoringSafeArea(.all)
          
            VStack {
                
                Button(action: {}, label: {
                    Image(systemName: "photo")
                }).padding()
                    .foregroundColor(.white)
                    .background(Color(hex: "#44F1A6"))
                    .cornerRadius(80)
                    
                
                HStack{
                    CustomTF(sfIcon: "person.fill", hint: "First Name ", value: $viewModel.firstName)
                    CustomTF(sfIcon: "person.fill", hint: "Last Name ", value: $viewModel.lastName)
                    
                }.padding(.horizontal, 40)
                    .padding(.top,30)
                CustomTF(sfIcon: "envelope.fill", hint: "Email ", value: $viewModel.email).padding(.horizontal, 40).padding(.top, 20)
                CustomTF(sfIcon: "phone.fill", hint: "Phone Number ", value: $viewModel.phoneNumber).padding(.horizontal, 40).padding(.top, 20)
                CustomTF(sfIcon: "lock.fill", hint: "Password ",isPassword: true, value: $viewModel.password).padding(.horizontal, 40).padding(.top, 20)
                CustomTF(sfIcon: "lock.fill", hint: "Confirm Password ",isPassword: true, value: $viewModel.confirmPassword).padding(.horizontal, 40).padding(.top, 20)
                
              
                
                Button("Register") {
                    viewModel.registerUser()
                    
                    print(viewModel.showSignup)
                }
                
                .fontWeight(.bold)
                .frame(maxWidth: 170)
                .frame(maxHeight: 40)
                .padding()
                .foregroundColor(.white)
                .background(Color(hex: "#44F1A6"))
                .cornerRadius(70)
                .padding(.horizontal, 40)
                .padding(.top, 20)
                NavigationLink(destination: LoginView(viewModel: loginViewModel, showSignup: $viewModel.showSignup), isActive: $viewModel.showSignIn) {
                    
                         EmptyView()
                     }
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
              
                
                Spacer()
                
                HStack {
                    Text("Already have an account ?")
                    Button("Sign In!") {
                        // Sign up action
                        showSignup = false
                    }
                    .foregroundColor(.blue)
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 100)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
