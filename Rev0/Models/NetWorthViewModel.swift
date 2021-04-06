import Foundation
import FirebaseFunctions

final class NetWorthViewModel: ObservableObject {
    
    @Published var currentBalance: Double = 0.0
    @Published var difference: Double = 0.0
    @Published var spent: Double = 0.0
    @Published var earned: Double = 0.0
    @Published var isLoading: Bool = true
    
    init(){
        PlaidAPI().getBalance(){ (netWorth) in
            DispatchQueue.main.async {
                self.currentBalance = netWorth
                self.earned = netWorth
                self.difference = self.earned - self.spent
                self.isLoading = false
                
            }
        }
    }
    
}
