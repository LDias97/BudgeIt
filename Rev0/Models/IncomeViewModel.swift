import Foundation
import FirebaseFunctions

final class IncomeViewModel: ObservableObject {
    
    @Published var income: [UserData.Transaction] = []
    @Published var total: Double = 0.0
    @Published var isLoading: Bool = true
    
    init(userData: UserData){
        self.total = userData.totalEarned * (-1)
        self.income = userData.income
    }
    
}
