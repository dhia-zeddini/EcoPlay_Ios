//
//  ResetPwdView.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 27/11/2023.
//

import SwiftUI

@available(iOS 15.0, *)
struct ResetPwdView: View {

 
    @State private var errorMessage: String = ""
    @State private var showingAlert = false
    @ObservedObject var viewModel: ResetPwdViewModel
    @Environment(\.dismiss) private var dismiss
    @available(iOS 16.0, *)
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
             
                
                    
                CustomTF(sfIcon: "lock", hint: "Password ",isPassword: true, value: $viewModel.password).padding(.horizontal, 40).padding(.top, 20)
                CustomTF(sfIcon: "lock", hint: "Confirm Password ",isPassword: true, value: $viewModel.confirmPassword).padding(.horizontal, 40).padding(.top, 20)

                Button("Save") {
                    if let userToken = UserDefaults.standard.string(forKey: "token") {
                        viewModel.newPwd(userToken: userToken)

                    }
                   

                    Task{
                        
                        try? await Task.sleep(for: .seconds(3))
                        if(!viewModel.showingAlert){
                            viewModel.reset()
                            dismiss()
                           
                        }
                        
                    }
                  
                }
                .disabled(viewModel.confirmPassword.isEmpty || viewModel.password.isEmpty)
                .opacity((viewModel.confirmPassword.isEmpty || viewModel.password.isEmpty) ? 0.6 : 1)
                .fontWeight(.bold)
                .frame(maxWidth: 170)
                .frame(maxHeight: 40)
                .padding()
                .foregroundColor(.white)
                .background(Color(hex: "#44F1A6"))
                .cornerRadius(70)
                .padding(.horizontal, 40)
                .padding(.top, 20)
                
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
           
                
           
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

