//
//  UserModel.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 28/11/2023.
//

import Foundation

struct UserModel: Codable {
    let _id: String
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let password: String
    let avatar: String
    let points: Int
    let score: Int
    let level: Int
    let goldMedal: Int
    let silverMedal: Int
    let bronzeMedal: Int
    var owned: [String]  // Use Array instead of MutableList
    let etatDelete: Bool
    let createdAt: String
    let updatedAt: String
    let __v: Int
}
