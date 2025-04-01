import SwiftUI

struct AppetizerListView: View {
    var body: some View {
        NavigationStack {
            List(MockAppetizerData.appetizers) { appetizer in
                AppetizerListCell(appetizer: appetizer)
            }
            .navigationTitle("🍟 Appetizers")
        }
    }
}

#Preview {
    AppetizerListView()
}
