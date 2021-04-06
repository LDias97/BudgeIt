import Foundation
import FirebaseFunctions

final class SpendingViewModel: ObservableObject {
    
    @Published var spending: [PlaidAPI.Transaction] = []
    @Published var total: Double = 0.0
    @Published var isLoading: Bool = true
    
    init(){
        PlaidAPI().getTransactions(){ (transactions, spending, income) in
            DispatchQueue.main.async {
                self.spending = spending
                for item in spending {
                    self.total += item.amount
                }
                self.isLoading = false
            }
        }
    }
    
}
