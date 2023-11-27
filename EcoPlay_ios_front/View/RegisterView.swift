//
//  RegisterView.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 26/11/2023.
//

import SwiftUI

struct RegisterView: View {
    @State private var phone = ""
    @State private var password = ""
    @Binding var showSignup: Bool
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
                    CustomTF(sfIcon: "person.fill", hint: "First Name ", value: $phone)
                    CustomTF(sfIcon: "person.fill", hint: "Last Name ", value: $phone)
                    
                }.padding(.horizontal, 40)
                    .padding(.top,30)
                CustomTF(sfIcon: "envelope.fill", hint: "Email ", value: $phone).padding(.horizontal, 40).padding(.top, 20)
                CustomTF(sfIcon: "phone.fill", hint: "Phone Number ", value: $phone).padding(.horizontal, 40).padding(.top, 20)
                CustomTF(sfIcon: "lock.fill", hint: "Password ",isPassword: true, value: $password).padding(.horizontal, 40).padding(.top, 20)
                CustomTF(sfIcon: "lock.fill", hint: "Confirm Password ",isPassword: true, value: $password).padding(.horizontal, 40).padding(.top, 20)
                
              
                
                Button("Register") {
                    // Login action
                }
                .disabled(phone.isEmpty||password.isEmpty)
                .fontWeight(.bold)
                .frame(maxWidth: 170)
                .frame(maxHeight: 40)
                .padding()
                .foregroundColor(.white)
                .background(Color(hex: "#44F1A6"))
                .cornerRadius(70)
                .padding(.horizontal, 40)
                .padding(.top, 20)
                
                
              
                
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
        //.padding(.top, 1)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
