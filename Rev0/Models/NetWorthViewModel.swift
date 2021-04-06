import Foundation

final class NetWorthViewModel: ObservableObject {
    
    var currentBalance: Double
    var previousBalance: Double
    var difference: Double
    var spent: Double
    var earned: Double
    
    init(){
        currentBalance = BankAccountViewModel().netWorth
        previousBalance = 130000.00
        difference = currentBalance - previousBalance
        spent = 1830.00
        earned = 1430
    }
    
    func update(){
        currentBalance = BankAccountViewModel().netWorth
        previousBalance = 130000.00
        difference = currentBalance - previousBalance
        spent = 1830.00
        earned = 1430
    }
    
}
