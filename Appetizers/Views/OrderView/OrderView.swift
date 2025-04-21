import SwiftUI

struct OrderView: View {
    
    @State private var orderItems = MockData.orderItems()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if orderItems.isEmpty {
                        EmptyState(type: .orders)
                    } else {
                        List {
                            ForEach(orderItems) { appetizer in
                                AppetizerListCell(appetizer: appetizer)
                            }
                            .onDelete { indexSet in
                                orderItems.remove(atOffsets: indexSet)
                            }
                        }
                        .listStyle(.plain)
                        
                        Button {
                            print("Place Order")
                        } label: {
                            APButton(title: "$99.99")
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

