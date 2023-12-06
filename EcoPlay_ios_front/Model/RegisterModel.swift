//
//  RegisterModel.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 28/11/2023.
//

import Foundation
import UIKit

struct RegisterRequestModel: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let password: String
    let avatar: Data?
    
}
struct RegisterResponse: Decodable {
    let status: Bool
    let success: String
    
}

struct UpdateAccountResponse: Decodable {
    let message: String
    
}
