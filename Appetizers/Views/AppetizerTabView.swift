import SwiftUI

struct AppetizerTabView: View {
    
    @EnvironmentObject var order: OrderViewModel
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                AppetizerListView()
            }
            
            Tab("Account", systemImage: "person") {
                AccountView()
            }
            
            Tab("Orders", systemImage: "bag") {
                OrderView()
            }
            .badge(order.items.count)
        }
        .tint(.brandPrimary)
    }
}

#Preview {
    AppetizerTabView()
}
