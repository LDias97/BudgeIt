import Foundation
import Firebase
import FirebaseFunctions

class PlaidAPI: ObservableObject {
    @Published var hasLoaded = false
    @Published var dismissed = false
    @Published var vc: ViewController = ViewController()
    @Published var netWorth = 0.0
    @Published var transactions: [Transaction] = []
    @Published var spending: [Transaction] = []
    @Published var income: [Transaction] = []
    @Published var totalSpent: Double = 0.0
    @Published var totalEarned: Double = 0.0
}

extension PlaidAPI {
    
    func getTokenFromCloud(completion: @escaping (String?) -> ()){
        Functions.functions().httpsCallable("createPlaidLinkToken").call { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return completion(nil)
            }
            guard let linkToken = result?.data as? String else {
                return completion(nil)
            }
            completion(linkToken)
        }
    }
    
    func setToken(){
        getTokenFromCloud { (linkToken) in
            guard let linkToken = linkToken , !linkToken.isEmpty else { return }
            DispatchQueue.main.async {
                self.vc.setToken(token: linkToken)
                self.hasLoaded = true
            }
        }
    }
    
    func getBalance(completion: @escaping (Double) -> ()){
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
            completion(netWorth)
        }
    }
    
    func getTransactions(completion: @escaping ([Transaction],[Transaction], [Transaction]) -> ()){
        
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
                let transaction = Transaction(category: (item["category"] as! [String]), name: item["name"] as! String, amount: item["amount"] as! Double, date: item["date"] as! String, pending: (item["pending"] != nil))
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
            completion(self.transactions, self.spending, self.income)
        }
    }
    
}

extension PlaidAPI {
    
    struct Transaction {
        let category: [String]?
        let name: String
        let amount: Double
        let date: String
        let pending: Bool
    }
    
}
