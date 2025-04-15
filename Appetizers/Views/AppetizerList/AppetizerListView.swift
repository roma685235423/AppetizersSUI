import SwiftUI

struct AppetizerListView: View {
    
    @StateObject private var viewModel = AppetizerListViewModel()
    
    var body: some View {
        ZStack {
            NavigationStack {
                List(viewModel.appetizers) { appetizer in
                    AppetizerListCell(appetizer: appetizer)
                        .onTapGesture {
                            viewModel.selectedAppetizer = appetizer
                            viewModel.isShowingDetailView = true
                            print("111")
                        }
                }
                .navigationTitle("🍟 Appetizers")
                .disabled(viewModel.isShowingDetailView)
            }
            .onAppear {
                viewModel.getAppetizers()
            }
            .blur(radius: viewModel.isShowingDetailView ? 20 : 0)
            .alert(viewModel.alertItem?.title ?? Text(""),
                   isPresented: $viewModel.isShowingAlert) {
            } message: {
                viewModel.alertItem?.message ?? Text("")
            }
            
            if viewModel.isLoading {
                loadingView()
            }
            
            if viewModel.isShowingDetailView, let selectedAppetizer = viewModel.selectedAppetizer {
                AppetizerDetailsView(appetizer: selectedAppetizer, isShowingDetailView: $viewModel.isShowingDetailView )
            }
        }
    }
}

#Preview {
    AppetizerListView()
}
