import SwiftUI

struct AppetizerTabView: View {
    
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
        }
        .tint(.brandPrimary)
    }
}

#Preview {
    AppetizerTabView()
}
