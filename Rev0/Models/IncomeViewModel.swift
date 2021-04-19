import Foundation
import FirebaseFunctions

final class IncomeViewModel: ObservableObject {
    
    @Published var income: [UserData.Transaction] = []
    @Published var categories: [UserData.Transaction] = []
    @Published var incomeByCategory: Dictionary<String, Double> = [String: Double]()
    @Published var total: Double = 0.0
    @Published var loaded: Bool = false
    
    init(userData: UserData){
        self.income = userData.income
        self.total = userData.totalEarned
        self.incomeByCategory = userData.incomeByCategory
        self.loaded = userData.hasLoaded
    }
    
}
