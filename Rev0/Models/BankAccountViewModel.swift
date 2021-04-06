import Foundation
import SwiftUI
import FirebaseFunctions

final class BankAccountViewModel: ObservableObject {
    
    @Published var netWorth = 0.0
    @Published var previousNetWorth = 0.0
    @Published var transactions: [Transaction]? = nil
    
    func getBalance(completion: @escaping ([NSMutableDictionary]) -> ()){
        let json: [String: Any] = [
            "accessToken": UserDefaults.standard.value(forKey: "access_token") as! String
        ]
        Functions.functions().httpsCallable("getBalance").call(json) { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            let accounts = result?.data
            completion(accounts as! [NSMutableDictionary])
        }
    }
    
    func setBalance() {
        getBalance { (data) in
            for account in data {
                let balance = account["balances"] as! NSMutableDictionary
                let current = balance["current"] as! Double
                self.netWorth += current
                print(self.netWorth)
            }
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
