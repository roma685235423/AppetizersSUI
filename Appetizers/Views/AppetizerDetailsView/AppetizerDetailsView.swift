import SwiftUI

struct AppetizerDetailsView: View {
    
    @EnvironmentObject var order: OrderViewModel
    
    let appetizer: AppetizerDTO
    @Binding var isShowingDetailView: Bool
    
    var body: some View {
        VStack {
            AppetizerRemoteImage(urlString: appetizer.imageURL)
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 225)
            Text(appetizer.name)
                .font(.title2)
                .fontWeight(.semibold)
            Text(appetizer.description)
                .multilineTextAlignment(.center)
                .font(.body)
                .padding()
            
            HStack(spacing: 40) {
                NutritionInfoView(title: "Calories", value: appetizer.calories)
                NutritionInfoView(title: "Carbs", value: appetizer.carbs)
                NutritionInfoView(title: "Protein", value: appetizer.protein )
            }
            
            Spacer()
            
            Button( "$\(appetizer.price, specifier: "%.2f") - Add to order") {
                order.add(appetizer)
                isShowingDetailView = false
            }
            .standardButtonStyle()
            .padding(.bottom, 20)
        }
        .frame(width: 300, height: 525)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 40)
        .overlay(alignment: .topTrailing) {
            Button {
                isShowingDetailView = false
            } label: {
                XDismissButton()
            }
        }
    }
}

#Preview {
    AppetizerDetailsView(appetizer: MockData.sampleAppetizer, isShowingDetailView: .constant(false ))
}
