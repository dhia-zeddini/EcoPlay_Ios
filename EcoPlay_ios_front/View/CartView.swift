import SwiftUI

struct CartView: View {
    @StateObject var cartViewModel = CartViewModel()

    var body: some View {
        VStack {
            Text("Cart")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .padding(.top, 70.0)

            ScrollView {
                VStack(spacing: 16) {

                    ForEach(cartViewModel.carts )
                    { 
                        product in
                        CartItemView(imageName: product.image,  productName: product.nameP, price: Double(product.priceP) ?? 0.0)

                    }

                }
                .padding()
            }

            Image("dodane")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 180)
                .overlay(
                    VStack {
                        Text("Amount: $" + String(format: "%.2f", Double(cartViewModel.totalAmount)))

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
                            .frame(width: 200) 
                        }
                    }
                )
        }
        .background(
            Image("ecoPlay_bachground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear {
            cartViewModel.fetchCartWithID()
        }
    }
}
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
