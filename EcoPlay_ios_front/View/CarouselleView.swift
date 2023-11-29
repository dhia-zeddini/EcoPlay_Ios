import SwiftUI

struct CarouselleView: View {
    @ObservedObject var carouselleViewModel: CarouselleViewModel

    init(carouselleViewModel: CarouselleViewModel = CarouselleViewModel()) {
        self.carouselleViewModel = carouselleViewModel
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Let's make your Account Special ...")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.green)
                        .multilineTextAlignment(.leading)
                        .padding([.bottom, .trailing], 30.0)
                        .frame(maxWidth: .infinity, alignment: .top)

                    // Decorated Frame for "Avatar Collection" Text
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .frame(width: 300.0, height: 40)
                            .shadow(radius: 2)
                            .blur(radius: 1)

                        Text("Avatar Collection")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(carouselleViewModel.products) { product in
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    CarouselleItemView(
                                        image: product.image,
                                        nameP: product.nameP,
                                        descriptionP: product.descriptionP,
                                        priceP: Double(product.priceP) ?? 0.0
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 80.0)
                }

                Spacer()
                    .padding(.top, 960.0)

                VStack {
                    Spacer()
                    ZStack {
                        Image("dodane")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 395, height: 250)

                        NavigationLink(destination: CartView()) {
                            Text("Go To Cart")
                                .font(.largeTitle)
                                .fontWeight(.light)
                                .foregroundColor(Color.black)
                        }
                    }
                }
            }
            .background(
                Image("ecoPlay_bachground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationBarHidden(true)
            .onAppear {
                self.carouselleViewModel.fetchProducts()
            }
        }
    }
}

struct CarouselleView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselleView()
    }
}
