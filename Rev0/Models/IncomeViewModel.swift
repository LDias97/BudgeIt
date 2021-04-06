import Foundation
import FirebaseFunctions

final class IncomeViewModel: ObservableObject {
    
    @Published var income: [PlaidAPI.Transaction] = []
    @Published var total: Double = 0.0
    @Published var isLoading: Bool = true
    
    init(){
        PlaidAPI().getTransactions(){ (transactions, spending, income) in
            DispatchQueue.main.async {
                self.income = income
                for item in income {
                    self.total += item.amount
                }
                self.isLoading = false
            }
        }
    }
    
}
