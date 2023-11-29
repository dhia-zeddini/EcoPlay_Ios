//
//  LoginModel.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 27/11/2023.
//

import Foundation


struct LoginResponse: Decodable {
    let status: Bool
    let token: String
    let error: String
}
struct ForgetPwdResponse: Decodable {
    let status: Bool
    let token: String
}



struct UserCredentials : Encodable{
    let data: String
    let password: String
}
