import SwiftUI

struct CarouselleItemView: View {
    var image: String?
    var nameP: String = "name Product"
    var descriptionP: String = "description"
    var priceP: Double = 0.0
    var placeholderImage: String = "placeholder-image"

    @State private var loadedImage: UIImage? = nil

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Spacer()

            if let imageName = image, let imageUrl = URL(string: "http://192.168.87.207:8088/images/product/\(imageName)") {
                  if loadedImage != nil {
                      Image(uiImage: loadedImage!)
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 150, height: 150)
                          .clipped()
                          .cornerRadius(10)
                  } else {
                      ProgressView()
                          .onAppear {
                              // Ensure that loadImage is called when the view appears
                              loadImage(from: imageUrl)
                          }
                  }
              } else {
                  Image(placeholderImage)
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .frame(width: 150, height: 150)
                      .clipped()
                      .cornerRadius(10)
              }

            Text(nameP)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .multilineTextAlignment(.center)
                .padding(.vertical, 20.0)

            Text(String(format: "%.2f", priceP))
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.black)

            Spacer()
        }
        .frame(width: 250, height: 330)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.green)
                .blur(radius: 1.0)
                .shadow(radius: 2)
        )
        .shadow(radius: 4)
        .padding(.horizontal, 5)
        .padding(.vertical, 10)
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
            } else if let data = data {
                if let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        loadedImage = uiImage
                    }
                    print("Image loaded successfully")
                }
            }
        }.resume()
    }}

struct CarouselleItemView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselleItemView()
            .previewLayout(.sizeThatFits)
    }
}
