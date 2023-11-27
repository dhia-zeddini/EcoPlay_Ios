//
//  ResetPwdView.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 27/11/2023.
//

import SwiftUI

struct ResetPwdView: View {

    @State private var password = ""
    @State private var confirmPwd = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Image("ecoPlay_background") // Make sure to replace "eco_play_background" with your actual image name
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                HStack {
                         Button(action: { dismiss() }) {
                                      Image(systemName: "xmark")
                                          .font(.title2)
                                  }
                                  .padding(.leading, 16)
                                  .foregroundColor(.black)

                                  Spacer()
                }.padding(.top,10)
               
                    Image("resetPwd_image")
                        .resizable()
                        .frame(width: 150,height: 150)
             
                
                    
                CustomTF(sfIcon: "lock", hint: "Password ",isPassword: true, value: $password).padding(.horizontal, 40).padding(.top, 20)
                CustomTF(sfIcon: "lock", hint: "Confirm Password ",isPassword: true, value: $confirmPwd).padding(.horizontal, 40).padding(.top, 20)

                Button("Send") {
                    // Login action
                  
                }
                .disabled(password.isEmpty || confirmPwd.isEmpty)
                .fontWeight(.bold)
                .frame(maxWidth: 170)
                .frame(maxHeight: 40)
                .padding()
                .foregroundColor(.white)
                .background(Color(hex: "#44F1A6"))
                .cornerRadius(70)
                .padding(.horizontal, 40)
                .padding(.top, 20)
                
                
           
                
           
            }
           // .padding(.top, 50)
        }
        .frame(height: 550)
        //.padding(.top, 20)
        .interactiveDismissDisabled()
    }
}

struct ResetPwdView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

