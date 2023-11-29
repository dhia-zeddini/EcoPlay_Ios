import SwiftUI

struct CartView: View {
    var body: some View {
        VStack {
            // Top Text View
            Text("Cart")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .padding(.top, 70.0)

            // Cart Item List
            ScrollView {
                VStack(spacing: 16) {
                    // Replace the following with your actual list of CartItemViews
                    CartItemView(imageName: "placeholder-image", productName: "Product Name 1", price: 19.99)
                    CartItemView(imageName: "placeholder-image", productName: "Product Name 2", price: 29.99)
                    CartItemView(imageName: "placeholder-image", productName: "Product Name 1", price: 19.99)
                    CartItemView(imageName: "placeholder-image", productName: "Product Name 1", price: 19.99)
                    CartItemView(imageName: "placeholder-image", productName: "Product Name 1", price: 19.99)
                    // Add more CartItemViews as needed
                }
            }
            // Decorative Image with Amount Text and Pay Button
            //Spacer() // To push the image and buttons to the bottom
            Image("dodane")
                .resizable()
                .aspectRatio(contentMode: .fill) // Use .fill to fill the
                .frame(height: 180) 
                .overlay(
                    VStack {
                        Text("Amount: $99.99") // Replace with your actual amount logic
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                        

                        Button(action: {
                            // Handle button action
                        }) {
                            HStack {
                                Text("Click here to pay")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 8)
                                    
                        

                                Image(systemName: "cart.fill")
                                    .foregroundColor(.white)
                            }
                            .background(Color.black)
                            .cornerRadius(10)
                            .frame(width: 900)
                        }
                    }
                )
        }
        .background(
            Image("ecoPlay_bachground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        ) // Adjust the background color as needed
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
