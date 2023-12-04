import SwiftUI

struct CartView: View {
    let currentCartId = "654567418bfbbff40a384edd"
    @StateObject var cartViewModel = CartViewModel()

    var body: some View {
        VStack {
            Text("Cart")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .padding(.top, 70.0)

            List {
                ForEach(cartViewModel.carts.indices, id: \.self) { index in
                    let product = cartViewModel.carts[index]
                    CartItemView(
                        imageName: product.image,
                        productName: product.nameP,
                        price: Double(product.priceP) ?? 0.0
                    )
                }
                .onDelete(perform: deleteItem)
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

    private func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let productId = cartViewModel.carts[index].id // Replace 'id' with the actual product ID property
            cartViewModel.deleteProductFromCart(productId: productId, cartId: currentCartId)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
