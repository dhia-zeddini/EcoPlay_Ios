import SwiftUI

struct CartView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(1...10, id: \.self) { index in
                        CartItemView(imageName: "product-image\(index)", productName: "Product \(index)", price: Double(index) * 5.99)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationBarTitle("Your Shopping Cart", displayMode: .inline)

            // Spacer to push the image to the bottom
            Spacer()

            // Image and Total Price
            Image("dodane")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFill()
                .frame(height: 200)
                .overlay(
                    Text("Total Price: $59.90")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                )
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
