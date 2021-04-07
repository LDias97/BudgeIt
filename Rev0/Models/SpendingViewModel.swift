import Foundation
import FirebaseFunctions

final class SpendingViewModel: ObservableObject {
    
    @Published var spending: [Dictionary<String, [UserData.Transaction]>] = []
    @Published var total: Double = 0.0
    @Published var isLoading: Bool = true
    
//    init(userData: UserData){
//        self.spending = userData.spending
//        for item in spending {
//            self.total += item.amount
//        }
//    }
    
}
