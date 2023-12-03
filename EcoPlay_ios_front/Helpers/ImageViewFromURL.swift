import SwiftUI

struct ImageViewFromURL: View {
    var imageURL: URL?
    @State private var loadedImage: UIImage? = nil

    var body: some View {
        if let url = imageURL {
            if loadedImage != nil {
                Image(uiImage: loadedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding(.top, 20.0)
                    .padding([.leading, .trailing], 20.0)
            } else {
                ProgressView()
                    .onAppear {
                        // Ensure that loadImage is called when the view appears
                        loadImage(from: url)
                    }
            }
        } else {
            // Use a placeholder image if the URL is nil
            Image("placeholder-image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding(.top, 20.0)
                .padding([.leading, .trailing], 20.0)
        }
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
    }
}
