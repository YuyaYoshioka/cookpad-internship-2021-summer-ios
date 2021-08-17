import SwiftUI

struct ProductDetailPageView: View {
    @EnvironmentObject var cartState: CartState
    @State var isCartViewPresented: Bool = false
    var product: FetchProductsQuery.Data.Product
    var body: some View {
        VStack(alignment: .leading) {
            RemoteImage(urlString: product.imageUrl)
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            Spacer()
                .frame(height: 8)
            Text(product.name)
                .padding(.leading, 8)
            Spacer()
                .frame(height: 8)
            Text(product.summary)
                .padding(.leading, 8)
            Spacer()
                .frame(height: 8)
            Text("\(product.price)円")
                .padding(.leading, 8)
        }
        Spacer()
        Button(action: {
            cartState.add(product: product)
        }) {
            Text("カートに追加")
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
        }
        .background(Color.orange)
        .cornerRadius(3)
        .frame(maxWidth: .infinity)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    self.isCartViewPresented = true
                }) {
                    VStack{
                        Image(systemName: "folder")
                        Text("(\(cartState.totalProductCounts))")
                    }
                }
            }
        }
        .sheet(isPresented: $isCartViewPresented) {
            NavigationView {
                CartPageView(isCartViewPresented: $isCartViewPresented)
            }
        }
    }
}

struct ProductDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailPageView(
                product: FetchProductsQuery.Data.Product(
                    id: UUID().uuidString,
                    name: "商品 \(1)",
                    price: 100,
                    summary: "おいしい食材 \(1)",
                    imageUrl: "https://image.mini-mart.com/dummy/1"
                )
            )
        }
        .environmentObject(CartState())
    }
}
