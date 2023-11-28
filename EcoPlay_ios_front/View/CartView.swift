import SwiftUI

struct CartView: View {
    var body: some View {
        VStack() {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(1...10, id: \.self) { index in
                        CartItemView(imageName: "product-image\(index)", productName: "Product \(index)", price: Double(index) * 5.99)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .frame(height: nil)
            
            Spacer()
            Image("dodane")
                .aspectRatio(contentMode: .fit)
        }
        .background(
                    Image("ecoPlay_bachground")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all))
        
        // Image at the end of the layout
   
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
