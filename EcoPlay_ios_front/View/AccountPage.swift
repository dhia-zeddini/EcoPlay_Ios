import SwiftUI

struct AccountPage: View {
    @ObservedObject  var profileViewModel: ProfileViewModel = ProfileViewModel()


    @State private var isEdit: Bool = false
    @State private var disabled: Bool = true
    @State private var showAlert: Bool = false
   
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ZStack {
            Image("ecoPlay_background") // Replace with your actual image name
                .resizable()
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading) {
                    AccountDetails(isEdit: $isEdit, disabled: $disabled, showAlert: $showAlert, profileViewModel: profileViewModel)
                    Settings()
                    Security()
                    
                }
                .padding(.leading, 0.0)
            }
        }
        .onAppear {
            if let userToken = UserDefaults.standard.string(forKey: "token") {
                profileViewModel.fetchUserProfile(userToken: userToken)

                print("token profile \(userToken)")
            }
        }
  
    }
    
    struct AccountDetails: View {
        @Binding var isEdit: Bool
        @Binding var disabled: Bool
        @Binding var showAlert: Bool
        @ObservedObject  var profileViewModel: ProfileViewModel
        var body: some View {
            VStack {
                HStack(spacing: 120) {
                    Text("Account Details")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(hex: "#03A9F4"))
                        .padding(20)
                        .frame(height: 42)
                        .padding(.top, 40)
                    
                    if isEdit {
                        Button(action: {
                            if let userToken = UserDefaults.standard.string(forKey: "token") {
                                profileViewModel.updateAccountUser(userToken: userToken)
                                

                                print("message profile \(profileViewModel.errorMessage)")
                            }
                            
                        }) {
                            Text("Done")
                                .foregroundColor(Color(hex: "#03A9F4"))
                                .padding(.horizontal, 20)
                                .frame(height: 42)
                                .padding(.top, 40)
                        } .alert(isPresented: $profileViewModel.showingAlert) {
                            Alert(
                                title: Text("Alert"),
                                message: Text(profileViewModel.errorMessage),
                                dismissButton: .default(Text("OK"),
                                                        action: {
                                                            isEdit = false
                                                            disabled = true
                                                        }
                                                       )
                            )
                        }
                        
                    } else {
                        Button(action: {
                           // isEdit = true
                            showAlert = true
                            
                        }) {
                            Text("Edit")
                                .foregroundColor(Color(hex: "#03A9F4"))
                                .padding(.horizontal, 20)
                                .frame(height: 42)
                                .padding(.top, 40)
                        }.alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Edit Profile"),
                                message: Text("Are you sure you want to edit your account?"),
                                primaryButton: .default(
                                    Text("Yes"),
                                    action: {
                                        isEdit = true
                                        disabled = false
                                    }
                                ),
                                secondaryButton: .destructive(
                                    Text("Cancel")
                                    
                                )
                            )
                        }
                    }
                }
                
                VStack {
                    CustomTF(sfIcon: "person.fill", hint: "First Name", value:  $profileViewModel.firstName).padding(.top, 10).disabled(disabled)
                    CustomTF(sfIcon: "person.fill", hint: "Last Name", value: $profileViewModel.lastName).disabled(disabled)
                    CustomTF(sfIcon: "envelope.fill", hint: "Email", value: $profileViewModel.email).disabled(disabled)
                    CustomTF(sfIcon: "phone.fill", hint: "Phone Number", value: $profileViewModel.phoneNumber).padding(.bottom, 20).disabled(disabled)
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .shadow(radius: 5)
            }
            
        }
    }
    struct Settings: View {
        @State private var isNotificationEnabled = false
        @State private var firstName = ""
        var body: some View {
            VStack(alignment: .leading) {
                
                Text("Settings")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(hex: "#03A9F4"))
                    .multilineTextAlignment(.leading)
                    .padding(20)
                    .frame(height: 42)
                    .padding(.top, 40)
                
                
                
                
                
                VStack {
                    Toggle("Notification", isOn: $isNotificationEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: Color.blue)) // Replace with your desired color
                        .padding(.horizontal, 26)
                        .padding(.top, 10)
                    
                    
                    Toggle("Updates", isOn: $isNotificationEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: Color.blue)) // Replace with your desired color
                        .padding(.horizontal, 26)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    Toggle("Dark Mode", isOn: $isNotificationEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: Color.blue)) // Replace with your desired color
                        .padding(.horizontal, 26)
                        .padding(.bottom, 20)
                    
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .shadow(radius: 5)
            }
        }
    }
    
    struct Security: View {
        @State private var showSignup: Bool = false
        @State private var showSignIn: Bool = true
        @State private var password = ""
        @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()
        var body: some View {
            VStack(alignment: .leading) {
                
                Text("Security")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(hex: "#03A9F4"))
                    .multilineTextAlignment(.leading)
                    .padding(20)
                    .frame(height: 42)
                    .padding(.top, 40)
                
                
                
                
                
                VStack {
                    CustomTF(sfIcon: "lock.fill", hint: "New Password ",isPassword: true, value: $password).padding(.top, 10)
                    CustomTF(sfIcon: "lock.fill", hint: "Confirm Password ",isPassword: true, value: $password).padding(.bottom, 10)
                    Button("Save") {
                        // Login action
                    }
                    .disabled(password.isEmpty)
                    .fontWeight(.bold)
                    .frame(maxWidth: 80)
                    .frame(maxHeight: 10)
                    .padding()
                    .foregroundColor(Color(hex: "#44F1A6"))
                    //.background(Color(hex: "#44F1A6"))
                    .cornerRadius(70)
                    .padding(.horizontal, 40)
                    
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                .shadow(radius: 5)
                
                Button("Logout"){
                    UserDefaults.standard.removeObject(forKey: "token")
                    print(showSignIn)
                    NavigationLink(destination: ContentView()) {

                         EmptyView()
                     }.isDetailLink(false)
                    
                }
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
                    .padding(20)
                    .frame(height: 42)
                    .padding(.bottom, 20)
                  
            }
        }
    }
    struct AccountPage_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
}
