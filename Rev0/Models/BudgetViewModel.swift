import Foundation
import SwiftUI

final class BudgetViewModel: ObservableObject, Identifiable {
    
    @Published var budgets: [Budget] = []
    
    init(userData: UserData){
        load(userData: userData)
    }
    
    func update(){
        for i in 0..<budgets.count {
            budgets[i].updateLimit()
            UserDefaults.standard.setValue(budgets[i].limit, forKey: budgets[i].category)
        }
    }
    
    func load(userData: UserData) {
        
        for category in UserData.Category.allCases {
            guard let limit = UserDefaults.standard.value(forKey: category.name) else {
                continue
            }
            let spent = CGFloat(userData.spendingByCategory[category.key] ?? 0)
            budgets.append(Budget(category: category.name, limit: limit as! CGFloat, spent: spent, percentage: spent / (limit as! CGFloat), color: category.color, iconName: category.iconName))
        }
        if budgets.count == 0 {
            budgets = [Budget(category: "Travel", limit: 1200, spent: 500, percentage: 500/1200, color: Color(.blue), iconName: "airplane"),
                       Budget(category: "Food & Restaurants", limit: 1200, spent: 500, percentage: 500/1200, color: Color(.systemTeal), iconName: "cart.fill"),
                       Budget(category: "Recreation", limit: 1200, spent: 500,  percentage: 500/1200, color: Color(.systemPink), iconName: "gamecontroller.fill"),
                       Budget(category: "Credit Card", limit: 1200, spent: 500, percentage: 500/1200, color: Color(.systemOrange), iconName: "creditcard.fill")]
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
        
        mutating func updateLimit(){
            self.percentage = self.spent / self.limit
        }
    }
    
}

