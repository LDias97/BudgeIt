import Foundation
import FirebaseFunctions
import SwiftUI

final class SpendingViewModel: ObservableObject {
    
    @Published var spending: [UserData.Transaction] = []
    @Published var categories: [String] = []
    @Published var spendingByCategory: Dictionary<String, Double> = [String: Double]()
    @Published var totalSpent: Double = 0.0
    @Published var slices: [Slice] = []
    @Published var selector: Selector?
    
    
    init(userData: UserData){
        self.spending = userData.spending
        self.spendingByCategory = userData.spendingByCategory
        self.totalSpent = userData.totalSpent
        for category in userData.spendingByCategory {
            self.categories.append(category.key)
        }
        self.selector = Selector(size: userData.spendingByCategory.count, categories: self.categories)
    }
    
    func getSlices(){
        
        var offset: CGFloat = 0.0
        for category in self.spendingByCategory {
            
            var color: Color?
            switch(category.key){
            case("Food"): color = Color(.systemTeal)
            case("Healthcare"): color = Color(.blue)
            case("Recreation"): color = Color(.systemYellow)
            case("Auto"): color = Color(.systemIndigo)
            case("Bills"): color = Color(.cyan)
            case("Travel"): color = Color(.magenta)
            case("Shopping"): color = Color(.systemPink)
            case("PersonalCare"): color = lightPurple
            case("HomeImprovement"): color = darkPurple
            case("Community"): color = Color(.green)
            case("Services"): color = Color(.green)
            case("Credit Card"): color = darkPurple
            default: color = Color(.systemGray)
            }
            
            let percent = CGFloat(category.value / self.totalSpent)
            let end  = offset + percent
            
            self.slices.append(Slice(start: offset,
                                     end: end,
                                     percentage: percent,
                                     name: category.key,
                                     color: color!))
            offset += percent
            
        }
    }
    
    struct Slice : Identifiable {
        
        var id = UUID()
        @State var start: CGFloat
        @State var end: CGFloat
        @State var percentage: CGFloat
        @State var name: String
        @State var color: Color
        
    }
    
    struct Selector {
        
        @State var size: Int
        @State var value: Int = 0
        @State var categories: [String]
        
    }
    
}

