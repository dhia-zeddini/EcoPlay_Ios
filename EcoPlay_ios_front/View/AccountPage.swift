import SwiftUI

struct AccountPage: View {
  
    @State private var isEdit = false

    var body: some View {
        ZStack {
            Image("ecoPlay_background") // Replace with your actual image name
                .resizable()
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading) {
                    AccountDetails(isEdit: $isEdit)
                    Settings()
                    Security()
                    Text("Delete Account")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.leading)
                        .padding(20)
                        .frame(height: 42)
                        .padding(.bottom, 20)
                }
                .padding(.leading, 0.0)
            }
        }
    }
}

struct AccountDetails: View {
    @Binding var isEdit: Bool
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""

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
                        isEdit = false
                    }) {
                        Text("Done")
                            .foregroundColor(Color(hex: "#03A9F4"))
                            .padding(.horizontal, 20)
                            .frame(height: 42)
                            .padding(.top, 40)
                    }
                } else {
                    Button(action: {
                        isEdit = true
                    }) {
                        Text("Edit")
                            .foregroundColor(Color(hex: "#03A9F4"))
                            .padding(.horizontal, 20)
                            .frame(height: 42)
                            .padding(.top, 40)
                    }
                }
            }

            VStack {
                CustomTF(sfIcon: "person.fill", hint: "First Name", value: $firstName).padding(.top, 10)
                CustomTF(sfIcon: "person.fill", hint: "Last Name", value: $lastName)
                CustomTF(sfIcon: "envelope.fill", hint: "Email", value: $email)
                CustomTF(sfIcon: "phone.fill", hint: "Phone Number", value: $phoneNumber).padding(.bottom, 20)
            }
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 20)
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
        }
    }
}

struct Security: View {
    @State private var isNotificationEnabled = false
    @State private var password = ""
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
        }
    }
}
struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
