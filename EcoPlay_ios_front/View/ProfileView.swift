//
//  ProfileView.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 27/11/2023.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedTab = 0
    @ObservedObject private var profileViewModel: ProfileViewModel = ProfileViewModel()
    @State private var showSignup: Bool = false
    @State private var showSignIn: Bool = true
    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()

    var body: some View {
        ZStack{
          
            NavigationView {
                VStack {

                    AsyncImage(url: profileViewModel.imageUrl) { phase in
                             switch phase {
                             case .empty:
                                 ProgressView()
                             case .success(let image):
                                 image
                                     .resizable()
                                     .cornerRadius(50)
                                     .frame(width: 80,height: 80)
                             case .failure:
                                 Image(systemName: "photo")
                                     .resizable()
                                     .scaledToFit()
                                     .foregroundColor(.red)
                             @unknown default:
                                 EmptyView()
                             }
                         }
                    
                    Text("Profile")
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(.horizontal, 40)
                        .padding(.top, 10)
                    
                    HStack (spacing: 25){
                        TabBarButton(text: "ACCOUNT", selectedTab: $selectedTab, assignedTab: 0)
                        TabBarButton(text: "ACHIEVEMENTS", selectedTab: $selectedTab, assignedTab: 1)
                        TabBarButton(text: "ACTIVITY", selectedTab: $selectedTab, assignedTab: 2)
                       
                    }.padding(.top, 10)
                    
                    
                    // Tab View Content
                    TabView(selection: $selectedTab) {
                        AccountPage(profileViewModel: profileViewModel)
                            .tag(0)
                        
                        AchievementsPage()
                            .tag(1)
                        
                      
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }.padding(.top,10)
                
                
            }   
        }.navigationBarBackButtonHidden(true)
          
    }
 }

 struct TabBarButton: View {
     let text: String
     @Binding var selectedTab: Int
     let assignedTab: Int

     var body: some View {
         Button(action: {
             selectedTab = assignedTab
         }) {
             Text(text)
                 .foregroundColor(selectedTab == assignedTab ? .blue : .gray)
         }
     }
 }




struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


