//
//  ItemView.swift
//  EcoPlay_ios_front
//
//  Created by mansouri sabri on 27/11/2023.
//

import SwiftUI

struct CarouselleItemView: View {
    var image :String = "placeholder-image"
    var nameP:String = "name Product"
    var descriptionP:String = "description"
    var priceP: Double = 0.0
    var body: some View {
        VStack(alignment:.leading, spacing: 8){
            Image(image)
                .aspectRatio(contentMode: .fill)
                .frame(width : 150, height: 150)
                .clipped()
                .cornerRadius(10)
            Text(nameP)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .multilineTextAlignment(.center)
            Text(descriptionP)
                .font(.subheadline)
            Text(String(format: "%.2f", priceP))
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Button (action: {}){
                
                    Text("Product details")
                        .font(.system(size:14))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,16)
                        .padding(.vertical,8)
                        .background(Color.black)
                        .cornerRadius(20)
                
                
                
            }
            .padding()
        
             
            }
        .frame(width: 250, height: 330)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius : 4)
        .padding(.horizontal,5)
            
        
    }
    
}

struct CarouselleItemView_Previews:PreviewProvider{
static var previews: some View {
CarouselleItemView()
        .previewLayout(.sizeThatFits)
       // .padding()
    }
}
