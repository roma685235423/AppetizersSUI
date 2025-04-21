import SwiftUI

struct OrderView: View {
    
    @State private var orderItems = MockData.orderItems()
    
    @EnvironmentObject var order: OrderViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if order.items.isEmpty {
                        EmptyState(type: .orders)
                    } else {
                        List {
                            ForEach(order.items) { appetizer in
                                AppetizerListCell(appetizer: appetizer)
                            }
                            .onDelete(perform: order.deleteItems)
                        }
                        .listStyle(.plain)
                        
                        Button {
                            print("Place Order")
                        } label: {
                            APButton(title: "$\(order.totalPrice, specifier: "%.2f")")
                        }
                    }
                }
            }
            .navigationTitle("🧾 Orders")
        }
    }
}

#Preview {
    OrderView()
}

