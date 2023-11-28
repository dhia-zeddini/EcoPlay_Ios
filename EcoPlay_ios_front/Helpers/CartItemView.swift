import SwiftUI

struct CartItemView: View {
    var imageName: String
    var productName: String
    var price: Double

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Left side - Image
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100) // Adjust the width and height of the image
                .clipped()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 2)
                )

            // Right side - Name and Price
            VStack(alignment: .leading, spacing: 8) {
                Text(productName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
                    .multilineTextAlignment(.leading)

                Text(String(format: "%.2f", price))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 250) // Adjust the width of the entire CartItemView
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.green, lineWidth: 2)
        )
        .shadow(radius: 4)
    }
}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView(imageName: "placeholder-image", productName: "Product Name", price: 19.99)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
