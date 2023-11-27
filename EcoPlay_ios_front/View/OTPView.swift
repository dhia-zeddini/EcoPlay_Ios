//
//  OTPView.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 27/11/2023.
//

import SwiftUI

struct OTPView: View {
    @Binding var showResetView: Bool
    @State private var otpText: String = ""
    @FocusState private var isKeyBoardShowing: Bool
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
                Image("Rating")
                    .resizable()
                    .frame(width: 120,height: 120)
             
                Text("We have send you a one time password on  this  Mobile Number")
                    .fontWeight(.bold)
                    .font(.title3)
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                HStack {
                    ForEach(0..<4,id: \.self){index in
                        OTPBox(index)
                    }
                }
                .background(content: {
                    TextField("",text: $otpText.limit(4))
                        .frame(width: 1,height: 1)
                        .opacity(0.001)
                        .blendMode(.screen)
                        .focused($isKeyBoardShowing)
                })
                .contentShape(Rectangle())
                .onTapGesture {
                    isKeyBoardShowing.toggle()
                }

                Button("Send") {
                    // Login action
                    Task{
                        dismiss()
                        try? await Task.sleep(for: .seconds(0))
                        showResetView = true
                    }
                }
                //.dissableWithOpacity(email.isEmpty)
                .fontWeight(.bold)
                .frame(maxWidth: 150)
                .frame(maxHeight: 30)
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
    @ViewBuilder
    func OTPBox(_ index: Int)->some View{
        ZStack{
            if otpText.count > index{
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex,offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
            }else{
                Text(" ")
            }
        }
        .frame(width: 65,height: 65)
        .background{
            RoundedRectangle(cornerRadius: 30,style: .continuous)
                .stroke(.gray,lineWidth: 0.5)
                
        }
        .frame(maxWidth: .infinity)
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Binding where Value == String{
    func limit(_ length: Int)->Self{
        if self.wrappedValue.count > length{
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
