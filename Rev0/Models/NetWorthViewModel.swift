import Foundation
import FirebaseFunctions

final class NetWorthViewModel: ObservableObject {
    
    @Published var currentBalance: Double = 0.0
    @Published var previousBalance: Double = UserDefaults.standard.double(forKey: "lastMonthBalance")
    @Published var difference: Double = 0.0
    @Published var spent: Double = 0.0
    @Published var earned: Double = 0.0
    @Published var isLoading: Bool = true
    
    init(){
        PlaidAPI().getBalance(){ (netWorth) in
            DispatchQueue.main.async {
                self.currentBalance = netWorth
                self.difference = self.currentBalance - self.previousBalance
                if (self.difference > 0) {
                    self.earned = self.difference
                }
                else {
                    self.spent = self.difference
                }
                self.isLoading = false
                
            }
        }
    }
    
}
