//
//  ProductDetailView.swift
//  EcoPlay_ios_front
//
//  Created by mansouri sabri on 27/11/2023.
//

import SwiftUI

struct ProductDetailView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Product Details")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding([.top], 40.0)

            Text("Gamer Kong")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .padding([.top, .trailing], 20.0)

            Image("monkey")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding(.top, 20.0)
                .padding([.leading, .trailing], 20.0)

            VStack {
                Text("Introducing the extraordinary kong  a whimsical companion ")
                    .font(.body)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20.0)
                    .padding([.leading, .trailing], 20.0)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.green, lineWidth: 2) // Green stroke
                            )
                    )
            }

            Text("Price: $" + String(format: "%.2f"))
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .padding([.top], 20.0)

            Spacer()

            Button(action: {
                print("button tapped")
            }) {
                HStack {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.green)
                            .frame(width: 30, height: 30)
                        Image(systemName: "cart")
                            .foregroundColor(.white)
                    }
                    Text("Add To My Cart")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(40)
            }
            .padding([.leading, .trailing], 40.0)
        }
        .frame(maxWidth: .infinity)
        .background(
            Image("ecoPlay_bachground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
    }
}
