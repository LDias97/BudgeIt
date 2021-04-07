import Foundation
import FirebaseFunctions

final class NetWorthViewModel: ObservableObject {
    
    @Published var currentBalance: Double = 0.0
    @Published var difference: Double = 0.0
    @Published var spent: Double = 0.0
    @Published var earned: Double = 0.0
    @Published var loaded: Bool = false
    
    init(userData: UserData){
        self.currentBalance = userData.netWorth
        self.earned = userData.totalEarned * (-1)
        self.spent = userData.totalSpent
        self.difference = self.earned - self.spent
        self.loaded = userData.hasLoaded
    }
    
}
