import Foundation
import Firebase
import FirebaseFunctions
import SwiftUI

class UserData: ObservableObject {
    @Published var hasLoaded = false
    @Published var netWorth = 0.0
    @Published var totalSpent = 0.0
    @Published var totalEarned = 0.0
    
    @Published var monthlyIncome = 0.0
    @Published var monthlySpending = 0.0
    @Published var monthlyDifference = 0.0
    
    @Published var transactions: [Transaction] = []
    @Published var spending: [Transaction] = []
    @Published var income: [Transaction] = []
    @Published var spendingByCategory: Dictionary<String, Double> = [String: Double]()
    @Published var incomeByCategory: Dictionary<String, Double> = [String: Double]()
    //    @Published var spending: [Dictionary<String, [Transaction]>] = []
    //    @Published var income: [Dictionary<String, [Transaction]>] = []
}

extension UserData
{
    func getBalance(){
        self.hasLoaded = false;
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
            self.hasLoaded = true;
        }
    }
    
    func getTransactions(){
        self.hasLoaded = false;
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current

        
        let components = calendar.dateComponents(_: [.year, .month], from: currentDate)
        let startOfMonth = calendar.date(from: components)

        let startDate = dateFormatter.string(from: startOfMonth!)
        let endDate = dateFormatter.string(from: currentDate)

        
//        Calendar.current.date(byAdding: .day, value: -30, to: currentDate)
        let json: [String: Any] = [
            "access_token": UserDefaults.standard.value(forKey: "access_token") as! String,
            "start_date": startDate,
            "end_date": endDate
        ]
        
        Functions.functions().httpsCallable("getTransactions").call(json) { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            let items = result?.data as! [NSMutableDictionary]
            for item in items {
                let name = (item["merchant_name"] as! NSObject == NSNull()) ? item["name"] : item["merchant_name"]
                var transaction = Transaction(categories: (item["category"] as! [String]), name: name as! String, amount: item["amount"] as! Double, date: item["date"] as! String, pending: (item["pending"] != nil))
                if ((item["amount"] as! Double) < 0) {
                    self.income.append(transaction)
                    self.totalEarned += transaction.amount
                }
                else {
                    for category in transaction.categories! {
                        var sum = transaction.amount
                        if category.contains("Healthcare"){
                            transaction.category = .Healthcare;
                            sum += self.spendingByCategory["Healthcare"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Healthcare")
                        }
                        else if category.contains("Recreation"){
                            transaction.category = .Recreation;
                            sum += self.spendingByCategory["Recreation"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Recreation")
                        }
                        else if category.contains("Shops"){
                            transaction.category = .Shopping;
                            sum += self.spendingByCategory["Shops"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Shops")
                        }
                        else if category.contains("Personal Care"){
                            transaction.category = .PersonalCare;
                            sum += self.spendingByCategory["PersonalCare"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "PersonalCare")
                        }
                        else if category.contains("Home Improvement"){
                            transaction.category = .HomeImprovement;
                            sum += self.spendingByCategory["HomeImprovement"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "HomeImprovement")
                        }
                        else if category.contains("Travel"){
                            transaction.category = .Travel;
                            sum += self.spendingByCategory["Travel"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Travel")
                        }
                        else if category.contains("Auto"){
                            transaction.category = .Auto;
                            sum += self.spendingByCategory["Auto"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Auto")
                        }
                        else if category.contains("Food"){
                            transaction.category = .Food;
                            sum += self.spendingByCategory["Food"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Food")
                        }
                    }
                    if transaction.category == nil {
                        transaction.category = .Miscellaneous
                    }
                    self.spending.append(transaction)
                    self.totalSpent += transaction.amount
                }
                self.transactions.append(transaction)
            }
            self.hasLoaded = true;
        }
    }
    
    func getBalanceByMonth() { // startYear: Int, startMonth: Int, startDay: Int) {
        
        let dateFormatter = DateFormatter()
        let currentDate = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current
        

        // First day of the month
        var components = calendar.dateComponents(_: [.year, .month], from: currentDate)
//        components.month = startMonth
//        components.day = startDay
//        components.year = startYear
        let startOfMonth = calendar.date(from: components)!

        // Last day of the month
        var comps2 = DateComponents()
//        comps2.month = 0
//        comps2.day = 30
//        comps2.year = 0
        comps2.month = 0
        comps2.day = 31
        let endOfMonth = calendar.date(byAdding: comps2, to: startOfMonth)
        
        let startDate = dateFormatter.string(from: startOfMonth)
        let endDate = dateFormatter.string(from: endOfMonth!)
        
        print(startDate)
        print(endDate)
        
        
        let json: [String: Any] = [
            "access_token": UserDefaults.standard.value(forKey: "access_token") as! String,
            "start_date": startDate,
            "end_date": endDate
        ]
        
        Functions.functions().httpsCallable("getTransactions").call(json) { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            let items = result?.data as! [NSMutableDictionary]
            for item in items {
                let name = (item["merchant_name"] as! NSObject == NSNull()) ? item["name"] : item["merchant_name"]
                let transaction = Transaction(categories: (item["category"] as! [String]), name: name as! String, amount: item["amount"] as! Double, date: item["date"] as! String, pending: (item["pending"] != nil))
                if ((item["amount"] as! Double) < 0) {
                    self.monthlySpending -= transaction.amount
                }
                else {
                    self.monthlyIncome += transaction.amount
                }
            }
            self.monthlyDifference =  self.monthlyIncome -  self.monthlySpending
            print(self.monthlyDifference)
            print(self.monthlyIncome)
            print(self.monthlySpending)
        }
    }
    
    func load(){
        getBalance()
        getTransactions()
        //getBalanceByMonth()
    }
}

extension UserData {
    
    struct Transaction: Identifiable {
        var id = UUID()
        let categories: [String]?
        var category: Category?
        let name: String
        let amount: Double
        let date: String
        let pending: Bool
        
        func color() -> Color {
            return category!.color
        }
    }
    
    enum Category : Int {
        case Food
        case Healthcare
        case Recreation
        case Auto
        case Bills
        case Travel
        case Shopping
        case PersonalCare
        case HomeImprovement
        case Community
        case Services
        case Miscellaneous
        
        static let names: [Category: String] = [
            .Food : "Food & Restaurants",
            .Healthcare : "Healthcare",
            .Recreation : "Entertainment",
            .Auto : "Auto & Transport",
            .Bills : "Bills",
            .Travel : "Travel",
            .Shopping : "Shopping",
            .PersonalCare : "Personal Care",
            .HomeImprovement : "Home Improvement",
            .Community :"Community",
            .Services : "Services",
            .Miscellaneous : "Miscellaneous"
        ]
        
        static let colors: [Category: Color] = [
            .Food : Color(.systemTeal),
            .Healthcare : Color(.blue),
            .Recreation : Color(.systemPink),
            .Auto : Color(.systemIndigo),
            .Bills : Color(.cyan),
            .Travel : Color(.orange),
            .Shopping : Color(.systemYellow),
            .PersonalCare : lightPurple,
            .HomeImprovement : darkPurple,
            .Community : Color(.magenta),
            .Services : Color(.green),
            .Miscellaneous : Color(.systemGray)
        ]
        
        var name: String {
            return Category.names[self]!
        }
        
        var color: Color {
            return Category.colors[self]!
        }
    }
    
}