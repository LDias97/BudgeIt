import Foundation
import Firebase
import FirebaseFunctions

class UserData: ObservableObject {
    @Published var hasLoaded = false
    @Published var netWorth = 0.0
    @Published var totalSpent = 0.0
    @Published var totalEarned = 0.0
    @Published var transactions: [Transaction] = []
    @Published var spending: [Transaction] = []
    @Published var income: [Transaction] = []
//    @Published var spending: [Dictionary<String, [Transaction]>] = []
//    @Published var income: [Dictionary<String, [Transaction]>] = []
}

extension UserData
{
    func getBalance(){
        let json: [String: Any] = [
            "accessToken": UserDefaults.standard.value(forKey: "access_token") as! String
        ]
        Functions.functions().httpsCallable("getBalance").call(json) { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            let accounts = result?.data as! [NSMutableDictionary]
            var netWorth = 0.0
            for account in accounts {
                let balance = account["balances"] as! NSMutableDictionary
                let current = balance["current"] as! Double
                netWorth += current
            }
            self.netWorth = netWorth
        }
    }
    
    func getTransactions(){
        let currentDate = Date()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let endDate = dateFormatterGet.string(from: currentDate)
        let startDate1 = Calendar.current.date(byAdding: .day, value: -30, to: currentDate)
        guard let startDate = startDate1 else {return}
        let startDateFormatted = dateFormatterGet.string(from: startDate)
        
        let json: [String: Any] = [
            "access_token": UserDefaults.standard.value(forKey: "access_token") as! String,
            "start_date": startDateFormatted,
            "end_date": endDate
        ]
        
        Functions.functions().httpsCallable("getTransactions").call(json) { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            let items = result?.data as! [NSMutableDictionary]
            for item in items {
                
                let name = (item["merchant_name"] as! NSObject == NSNull()) ? item["name"] : item["merchant_name"]
                let transaction = Transaction(category: (item["category"] as! [String]), name: name as! String, amount: item["amount"] as! Double, date: item["date"] as! String, pending: (item["pending"] != nil))
                if ((item["amount"] as! Double) < 0) {
                    self.income.append(transaction)
                    self.totalEarned += transaction.amount
                }
                else {
                    self.spending.append(transaction)
                    self.totalSpent += transaction.amount
                }
                self.transactions.append(transaction)
            }
        }
    }
    
    func load(){
        getBalance()
        getTransactions()
    }
}

extension UserData {
    
    struct Transaction: Identifiable {
        var id = UUID()
        let category: [String]?
        let name: String
        let amount: Double
        let date: String
        let pending: Bool
    }
    
}
