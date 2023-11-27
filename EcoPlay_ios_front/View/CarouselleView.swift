import SwiftUI

struct CarouselleView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Let's make your Account Special")
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .padding([.bottom, .trailing], 30.0)
                    .frame(maxWidth: .infinity, alignment: .top)
                
                Text("Avatar Collection")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
                    .multilineTextAlignment(.leading)
                    .padding(.trailing, 150.0)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0..<10) { index in
                            CarouselleItemView(
                                image: "imagep",
                                nameP: "name Product",
                                priceP: 0.0
                            )
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
                        
                    Text("Check Your Cart")
                        .font(.body)
                        .fontWeight(.bold)
                        
                                        }
            }
        }
    }
}

struct CarouselleView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselleView()
    }
}
