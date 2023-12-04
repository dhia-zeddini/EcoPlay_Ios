import SwiftUI

struct ProductDetailView: View {
    var product: ProductModel
    @StateObject private var cartViewModel = CartViewModel() // Initialize CartViewModel here
    @State private var statusMessage: String?
    @State private var showToast = false
        @State private var toastMessage = ""
      let cartId = "654567418bfbbff40a384edd"

    var createdAt: String
    var updatedAt: String
    var __v: Int

    init(product: ProductModel, createdAt: String = "", updatedAt: String = "", __v: Int = 0) {
        self.product = product
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.__v = __v
    }

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Product Details")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding([.top], 40.0)

            Text(product.nameP)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .padding([.top, .trailing], 20.0)

            // Use ImageViewFromURL instead of Image
            ImageViewFromURL(imageURL: URL(string: "http://192.168.87.207:8088/images/product/\(product.image)"))

            VStack {
                Text(product.descriptionP)
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

            Text("Price: $" + String(format: "%.2f", Double(product.priceP) ?? 0.0))
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .padding([.top], 20.0)

            Spacer()

            Button(action: {
                cartViewModel.addProductToCart(productId: product.id, cartId: cartId) { success, message in
                    // Set toast message based on the response
                    toastMessage = message
                    showToast = true

                    // Optionally, hide the toast after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showToast = false
                    }
                }
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
            .toast(message: toastMessage, isShowing: showToast)

        }
        .frame(maxWidth: .infinity)
        .background(
            Image("backgrounddv")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide values for createdAt, updatedAt, and __v
        ProductDetailView(
            product: ProductModel(id: "1", nameP: "Sample Product", descriptionP: "Sample Description", image: "placeholder-image", priceP: "29.99", typeP: "Sample Type", createdAt: "SampleCreatedAt", updatedAt: "SampleUpdatedAt", __v: 1)
        )

    }
}
