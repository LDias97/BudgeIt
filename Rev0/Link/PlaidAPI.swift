import Foundation
import Firebase
import FirebaseFunctions

class PlaidAPI: ObservableObject {
    @Published var hasLoaded = false
    @Published var dismissed = false
    @Published var vc: ViewController = ViewController()
    @Published var transactions: [Transaction]? = nil
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
            completion(netWorth)
        }
    }
    
    func getTransactions(completion: @escaping ([NSMutableDictionary]) -> ()){
        
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
            let transactions = result?.data
            completion(transactions as! [NSMutableDictionary])
        }
    }
    
    func setTransaction() {
        getTransactions { (data) in
            for item in data {
                let transaction = item["amount"] as! Double
                print(transaction)
            }
        }
    }
    
}
