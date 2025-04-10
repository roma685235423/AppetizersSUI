import SwiftUI

struct AppetizerListView: View {
    
    @StateObject private var viewModel = AppetizerListViewModel()
    
    var body: some View {
        ZStack {
            NavigationStack {
                List(viewModel.appetizers) { appetizer in
                    AppetizerListCell(appetizer: appetizer)
                }
                .navigationTitle("🍟 Appetizers")
            }
            .onAppear {
                viewModel.getAppetizers()
            }
            .alert(viewModel.alertItem?.title ?? Text(""),
                   isPresented: $viewModel.isShowingAlert) {
            } message: {
                viewModel.alertItem?.message ?? Text("")
            }
            
            if viewModel.isLoading {
                loadingView()
            }
        }
    }
}

#Preview {
    AppetizerListView()
}
