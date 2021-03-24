import Foundation
import SwiftUI
import Combine

class BudgetViewModel: ObservableObject, Identifiable {
    
    @Published var budgets: [Budget]
    
    init(){
        budgets = [Budget(category: "Auto & Transport", limit: 1200, spent: 500, color: Color(.blue), iconName: "car.fill"),
                   Budget(category: "Food & Restaurants", limit: 1200, spent: 500, color: Color(.systemTeal), iconName: "cart.fill"),
                   Budget(category: "Entertainment", limit: 1200, spent: 500, color: Color(.systemPink), iconName: "gamecontroller.fill"),
                   Budget(category: "Bills", limit: 1200, spent: 500, color: Color(.systemOrange), iconName: "house.fill")]
    }
    
    
    struct Budget: Hashable, Identifiable {
        var id = UUID()
        var category: String
        var limit: CGFloat
        var spent: CGFloat
        var percentage: CGFloat
        var color: Color
        var iconName: String
        
        init(category: String, limit: CGFloat, spent: CGFloat, color: Color, iconName: String){
            self.category = category
            self.limit = limit
            self.spent = spent
            self.color = color
            self.iconName = iconName
            percentage = spent / limit
        }
        
    }
    
}
