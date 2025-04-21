import SwiftUI

@main
struct AppetizersApp: App {
    
    var order = OrderViewModel()
    
    var body: some Scene {
        WindowGroup {
            AppetizerTabView().environmentObject(order)
        }
    }
}
