//
//  LoginView.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 26/11/2023.
//

import SwiftUI

struct LoginView: View {
   
    
    @State private var showForgetPwdView: Bool = false
    @State private var showResetView: Bool = false
    @State private var showOtpView: Bool = false
    @State private var isLoggedIn = false
    @Binding var showSignup: Bool
    @State private var errorMessage: String = ""
    @State private var showingAlert = false
    @ObservedObject var viewModel: LoginViewModel
    @ObservedObject var forgetPwdViewModel: ForgetPwdViewModel = ForgetPwdViewModel()
    @ObservedObject var otpViewModel: OTPViewModel = OTPViewModel()

    init(viewModel: LoginViewModel, showSignup: Binding<Bool>) {
         self.viewModel = viewModel
         self._showSignup = showSignup
     }
    var body: some View {
        ZStack {
            Image("eco_play_background") 
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("clipart") .padding(.bottom, 40)
                CustomTF(sfIcon: "phone", hint: "Phone Number ", value: $viewModel.data).padding(.horizontal, 40)
                CustomTF(sfIcon: "lock", hint: "Password ",isPassword: true, value: $viewModel.password).padding(.horizontal, 40).padding(.top, 20)
                
                HStack {
                    Spacer() // This will push the button to the right
                    Button("Forgot Password?") {
                        // Forgot password action
                        showForgetPwdView.toggle()
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 40)
                }
                .padding(.top, 5)
                
                Button("Login") {
                    
                    viewModel.loginUser()
                  
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
                .disabled(viewModel.data.isEmpty || viewModel.password.isEmpty)
                .opacity((viewModel.data.isEmpty || viewModel.password.isEmpty) ? 0.6 : 1)
                NavigationLink(destination: ProfileView(), isActive: $viewModel.isLoggedIn) {
                         EmptyView()
                     }
                     .isDetailLink(false)  // Add this line to prevent issues with NavigationLink inside a sheet

                     .alert(isPresented: $viewModel.showingAlert) {
                         Alert(
                             title: Text("Error"),
                             message: Text(viewModel.errorMessage),
                             dismissButton: .default(Text("OK"))
                         )
                     }
                HStack {
                    Text("Or Sign up With")
                        .foregroundColor(.black)
                }
                .padding(.top, 20)
                
                HStack(spacing: 20) {
                    Button(action: {
                        // Google login action
                    }) {
                        Image("logo_google")  
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    }
                    
                    Button(action: {
                        // Facebook login action
                    }) {
                        Image("logo_facebook")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    }
                    
                    Button(action: {
                        // Apple login action
                    }) {
                        Image(systemName: "applelogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                    }
                }
                
                Spacer()
                
                HStack {
                    Text("Don’t have an account?")
                    Button("Sign Up!") {
                        // Sign up action
                        showSignup.toggle()
                    }
                    .foregroundColor(.blue)
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 150)
        }
        //.padding(.top, 1)
        .sheet(isPresented: $showForgetPwdView, content: {
            ForgetPwdView(showOtpView: $showOtpView, viewModel: forgetPwdViewModel)
                .presentationDetents([.height(400)])
                .presentationCornerRadius(30)
        })
        .sheet(isPresented: $showOtpView, content: {
            OTPView(showResetView: $showResetView, viewModel: otpViewModel )
                .presentationDetents([.height(400)])
                .presentationCornerRadius(30)
        })
        .sheet(isPresented: $showResetView, content: {
            ResetPwdView()
                .presentationDetents([.height(400)])
                .presentationCornerRadius(30)
        })
    }
    


}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
extension View{
    func dissableWithOpacity(_ condition: Bool)-> some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}
