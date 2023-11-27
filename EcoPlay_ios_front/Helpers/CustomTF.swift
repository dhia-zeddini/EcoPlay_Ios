//
//  CustomTF.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 26/11/2023.
//

import SwiftUI

struct CustomTF: View {
    var sfIcon: String
    var iconTint: Color = Color(hex: "#44F1A6")
    var hint: String
    var isPassword: Bool = false
    @State var showPassword: Bool = false
    
    @Binding var value: String
    var body: some View {
        HStack(alignment: .top,spacing: 8, content: {
            Image(systemName: sfIcon)
                .foregroundColor(iconTint)
                .frame(width: 30)
            
            VStack(alignment: .leading,spacing: 8, content: {
                if isPassword{
                    Group{
                        if showPassword{
                            TextField(hint,text: $value)

                        }else{
                            SecureField(hint,text: $value)

                        }
                    }
                }else{
                    TextField(hint,text: $value)
                }
                Divider()
            })
            .overlay(alignment: .trailing){
                if isPassword{
                    Button(action: {
                        withAnimation{
                            showPassword.toggle()
                            
                        }
                    } ,label: {
                        Image(systemName: showPassword ?  "eye.slash" : "eye")
                            .foregroundColor(Color(hex: "#44F1A6"))
                            .padding(10)
                            //.contentShape(.rect)
                        
                    })
                }
            }
        })
        .padding(.top, 10)
        .background(.white)
        .cornerRadius(30)
        //.padding(.horizontal, 40)
        
        
    }
}


