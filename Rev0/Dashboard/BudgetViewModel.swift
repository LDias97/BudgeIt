import Foundation
import SwiftUI
import Combine

final class BudgetViewModel: ObservableObject, Identifiable {
    
    @Published var budgets: [Budget]
    @Published var limits: [CGFloat]
    
    init(){
        budgets = [Budget(category: "Auto & Transport", limit: 1200, spent: 500, percentage: 500/1200, color: Color(.blue), iconName: "car.fill"),
                   Budget(category: "Food & Restaurants", limit: 1200, spent: 500, percentage: 500/1200, color: Color(.systemTeal), iconName: "cart.fill"),
                   Budget(category: "Entertainment", limit: 1200, spent: 500,  percentage: 500/1200, color: Color(.systemPink), iconName: "gamecontroller.fill"),
                   Budget(category: "Bills", limit: 1200, spent: 500, percentage: 500/1200, color: Color(.systemOrange), iconName: "house.fill")]
        limits = [1200.00,1200.00,1200.00,1200.00]
    }
    
    func updateLimits(limits: [CGFloat]){
        for i in 0..<limits.count {
            budgets[i].limit = limits[i]
        }
    }
    
    
    struct Budget: Hashable, Identifiable {
        var id = UUID()
        var category: String
        var limit: CGFloat
        var spent: CGFloat
        var percentage: CGFloat
        var color: Color
        var iconName: String
        
        mutating func updateLimit(limit: CGFloat){
            self.limit = limit
            self.percentage = self.spent / self.limit
        }
    }
    
}
