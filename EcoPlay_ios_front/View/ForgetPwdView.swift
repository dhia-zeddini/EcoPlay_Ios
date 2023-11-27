//
//  ForgetPwdView.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 26/11/2023.
//

import SwiftUI

struct ForgetPwdView: View {
    @Binding var showOtpView: Bool
    @State private var email = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Image("ecoPlay_background") // Make sure to replace "eco_play_background" with your actual image name
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                HStack {
                  Button(action: { dismiss() }) {
                                      Image(systemName: "arrow.left")
                                          .font(.title2)
                                  }
                                  .padding(.leading, 16)
                                  .foregroundColor(.black)

                                  Spacer()
                              }
                Text("EcoPlay will send you an email with verification code")
                    .fontWeight(.bold)
                    .font(.title2)
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
              CustomTF(sfIcon: "envelope", hint: "Email ", value: $email).padding(.top, 50).padding(.horizontal, 40)

                Button("Send") {
                    // Login action
                    Task{
                        dismiss()
                        try? await Task.sleep(for: .seconds(0))
                        showOtpView = true
                    }
                }
                .dissableWithOpacity(email.isEmpty)
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
        .frame(height: 600)
        //.padding(.top, 20)
        .interactiveDismissDisabled()
    }
}

struct ForgetPwdView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
