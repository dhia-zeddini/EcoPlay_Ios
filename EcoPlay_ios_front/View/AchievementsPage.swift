//
//  AchievementsPage.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 27/11/2023.
//

import SwiftUI

struct AchievementsPage: View {
    @ObservedObject  var profileViewModel: ProfileViewModel = ProfileViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Custom card
                VStack(alignment: .leading,spacing: 20) {
                    HStack(spacing: 10) {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 40, height: 37)
                            .overlay(Text(profileViewModel.level).foregroundColor(.white))

                        VStack(alignment: .leading) {
                            Text("Level \(profileViewModel.level)")
                                .bold()
                            Text("\(profileViewModel.score) Points to next level")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top,10)

                    ProgressBar(progress: 0.86)
                        .frame(height: 37)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)

                }
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .padding(.top, 30)
                .shadow(radius: 4)

                Text("STATS")
                    .bold()
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)

                // Stats TableLayout
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        StatCard(imageName: "quizp", title: "55", subtitle: "Quizzes")
                        StatCard(imageName: "ecoleaderb", title: "#2", subtitle: "Leaderboard")
                    }
                    
                    HStack(spacing: 20) {
                        StatCard(imageName: "checkprofil", title: "83%", subtitle: "Accuracy")
                        StatCard(imageName: "recall", title: "86%", subtitle: "Recall")
                    }
                }
                .padding(.horizontal, 10)

                Text("MEDALS")
                    .bold()
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)

                // Medals Layout
                // Medals Section
                HStack(spacing: 20) {
                    MedalCard(medalType: "Gold", count: profileViewModel.goldMedal, color: "#EDB552")
                    MedalCard(medalType: "Silver", count: profileViewModel.silverMedal, color: "#717484")
                    MedalCard(medalType: "Bronze", count: profileViewModel.bronzeMedal, color: "#AA9083")
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)


              
            }
        }.onAppear {
            if let userToken = UserDefaults.standard.string(forKey: "token") {
                profileViewModel.fetchUserProfile(userToken: userToken)

                print("token profile \(userToken)")
            }
        }
    }
}

struct ProgressBar: View {
    var progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(#colorLiteral(red: 1, green: 0.9725490196, blue: 0.8980392157, alpha: 1)))
                    .frame(width: geometry.size.width, height: geometry.size.height)

                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.yellow)
                    .frame(width: min(CGFloat(self.progress) * geometry.size.width, geometry.size.width), height: geometry.size.height)
            }
        }
    }
}
struct StatCard: View {
    var imageName: String
    var title: String
    var subtitle: String

    var body: some View {
        HStack {
            Image(imageName) // Replace with actual images
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                Text(subtitle)
            }
        }
        .frame(width: 170, height: 100)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
        .shadow(radius: 2)
    }
}
struct MedalCard: View {
    var medalType: String
    var count: String
    var color: String

    var body: some View {
        VStack {
            Image(medalType.lowercased() + "_medal") // Replace with actual images
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            
            Text(medalType)
                .bold()
            Text(count)
                .foregroundColor(Color(hex: self.color))
                .padding(5)
                .background(Image(medalType.lowercased() + "_rect"))
                .padding(.bottom, 5)

        }
        .frame(width: 100)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
        .shadow(radius: 4)
    }
}

struct AchievementsPage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
