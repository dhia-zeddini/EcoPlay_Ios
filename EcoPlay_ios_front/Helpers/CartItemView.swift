import SwiftUI

struct CartItemView: View {
    var imageName: String? // Make this an optional
    var productName: String
    var price: Double

    @State private var loadedImage: UIImage? = nil

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Group {
                // Check if an image name is provided and construct the URL
                if let imageName = imageName,
                   let encodedImageName = imageName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
                   let imageUrl = URL(string: "http://192.168.87.207:8088/images/product/\(encodedImageName)") {
                    // Image loading logic
                    if let loadedImage = loadedImage {
                        Image(uiImage: loadedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipped()
                            .cornerRadius(10)
                    } else {
                        ProgressView()
                            .onAppear {
                                loadImage(from: imageUrl)
                            }
                    }
                } else {
                    // Fallback placeholder image
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipped()
                        .cornerRadius(10)
                }
            }

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
            .frame(width: 120)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.green, lineWidth: 2)
        )
        .shadow(radius: 4)
        .onAppear {
            print("CartItemView appeared for product: \(productName), image name: \(String(describing: imageName))")
        }
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                } else if let data = data, let uiImage = UIImage(data: data) {
                    self.loadedImage = uiImage
                    print("Image loaded successfully")
                } else {
                    print("Could not create UIImage from data or no data received from URL: \(url)")
                }
            }
        }.resume()
    }
}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView(imageName: "Danous1700574990468.jpeg", productName: "Danous", price: 150.00)
            .previewLayout(.sizeThatFits)
    }
}
