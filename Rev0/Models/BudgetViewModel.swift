import Foundation
import SwiftUI
import UIKit
import UserNotifications

final class BudgetViewModel: ObservableObject, Identifiable {
    
    @Published var budgets: [Budget] = [Budget]()
    @Published var exceedBudget: Bool = false
    var value: UIAlertController = UIAlertController()
    //var alertController: UIAlertController?
    
    init(userData: UserData){
        load(userData: userData)
    }
    
    
    func update(){
        for i in 0..<budgets.count {
            budgets[i].updateLimit()
            UserDefaults.standard.setValue(budgets[i].limit, forKey: budgets[i].category)
        }
    }
    
    func addBudget(category: UserData.Category){
        budgets.append(Budget(category: category.name, limit: 0, spent: 0, percentage: 0, color: category.color, iconName: category.iconName))
        update()
    }
    
    
    func remove(budget: Budget){
        for index in self.budgets.indices {
            if (budgets[index].category == budget.category) {
                budgets.remove(at: index)
                UserDefaults.standard.removeObject(forKey: budget.category);
                return
            }
        }
    }
    
    func notify(category: String) {        
        let alert = UNMutableNotificationContent()
        alert.title = "Budget Limit Exceeded"
        alert.body = "You have exceeded your " + category  + " budget!"
        alert.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "FiveSeconds", content: alert, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    
    func load(userData: UserData) {
        
        for category in UserData.Category.allCases {
            guard let limit = UserDefaults.standard.value(forKey: category.name) else {
                continue
            }
            let spent = CGFloat(userData.spendingByCategory[category.key] ?? 0)
            budgets.append(Budget(category: category.name, limit: limit as! CGFloat, spent: spent, percentage: spent / (limit as! CGFloat), color: category.color, iconName: category.iconName))
            let i = budgets.count - 1
            if(budgets[i].spent >= budgets[i].limit){
                notify(category: budgets[i].category)
            }
        }
        if budgets.count == 0 {
            budgets = [Budget(category: "Travel", limit: 1200, spent: 500, percentage: 500/1200, color: Color(.blue), iconName: "airplane"),
                       Budget(category: "Food & Restaurants", limit: 1200, spent: 500, percentage: 500/1200, color: Color(.systemTeal), iconName: "cart.fill"),
                       Budget(category: "Recreation", limit: 1200, spent: 500,  percentage: 500/1200, color: Color(.systemPink), iconName: "gamecontroller.fill"),
                       Budget(category: "Credit Card", limit: 1200, spent: 500, percentage: 500/1200, color: Color(.systemOrange), iconName: "creditcard.fill")]
        }
}
    
    
    
    struct Budget: Hashable, Identifiable {
        let id = UUID()
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

//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) {
//            success, error in
//            if success {
//                print("All set!")
//            } else if let error = error {
//                print(error.localizedDescription)
//            }
//        }
