import Foundation
import Firebase
import FirebaseFunctions
import SwiftUI

final class UserData: ObservableObject {
    @Published var hasLoaded = false
    @Published var netWorth = 0.0
    @Published var totalSpent = 0.0
    @Published var totalEarned = 0.0
    @Published var transactions: [Transaction] = []
    @Published var spending: [Transaction] = []
    @Published var income: [Transaction] = []
    @Published var spendingByCategory: Dictionary<String, Double> = [String: Double]()
    @Published var incomeByCategory: Dictionary<String, Double> = [String: Double]()
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
        let firstOfMonth = calendar.date(from: calendar.dateComponents(_: [.year, .month], from: currentDate))

        let startDate = dateFormatter.string(from: firstOfMonth!)
        let endDate = dateFormatter.string(from: currentDate)

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
                    var found = false
                    var transfer = false
                    for category in transaction.categories! {
                        if(!found){
                        var sum = transaction.amount
                        if category.contains("Healthcare"){
                            transaction.category = .Healthcare;
                            sum += self.spendingByCategory["Healthcare"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Healthcare")
                            found = true
                        }
                        else if category.contains("Recreation"){
                            transaction.category = .Recreation;
                            sum += self.spendingByCategory["Recreation"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Recreation")
                            found = true

                        }
                        else if category.contains("Shops"){
                            transaction.category = .Shopping;
                            sum += self.spendingByCategory["Shops"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Shops")
                            found = true

                        }
                        else if category.contains("Personal Care"){
                            transaction.category = .PersonalCare;
                            sum += self.spendingByCategory["PersonalCare"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "PersonalCare")
                            found = true

                        }
                        else if category.contains("Home Improvement"){
                            transaction.category = .HomeImprovement;
                            sum += self.spendingByCategory["HomeImprovement"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "HomeImprovement")
                            found = true

                        }
                        else if category.contains("Travel"){
                            transaction.category = .Travel;
                            sum += self.spendingByCategory["Travel"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Travel")
                            found = true

                        }
                        else if category.contains("Auto"){
                            transaction.category = .Auto;
                            sum += self.spendingByCategory["Auto"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Auto")
                            found = true

                        }
                        else if category.contains("Food"){
                            transaction.category = .Food;
                            sum += self.spendingByCategory["Food"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Food")
                            found = true

                        }
                        else if category.contains("Credit Card"){
                            transaction.category = .CC;
                            sum += self.spendingByCategory["Credit Card"] ?? 0
                            self.spendingByCategory.updateValue(_: sum, forKey: "Credit Card")
                            found = true
                        }
                        else if category.contains("Transfer"){
                            transfer = true
                        }
                        }

                    }
                    if !found && !transfer {
                        transaction.category = .Miscellaneous
                        var sum = self.spendingByCategory["Miscellaneous"] ?? 0
                        sum += transaction.amount
                        self.spendingByCategory.updateValue(_: sum, forKey: "Miscellaneous")
                    }
                    if !transfer{
                        self.spending.append(transaction)
                        self.transactions.append(transaction)
                        self.totalSpent += transaction.amount
                    }
                }
            }
            self.hasLoaded = true;
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
    
    enum Category : Int, CaseIterable {
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
        case CC
        
        static let names: [Category: String] = [
            .Food : "Food & Restaurants",
            .Healthcare : "Healthcare",
            .Recreation : "Recreation",
            .Auto : "Auto & Transport",
            .Bills : "Bills",
            .Travel : "Travel",
            .Shopping : "Shopping",
            .PersonalCare : "Personal Care",
            .HomeImprovement : "Home Improvement",
            .Community :"Community",
            .Services : "Services",
            .Miscellaneous : "Miscellaneous",
            .CC : "Credit Card"

        ]
        
        static let keys: [Category: String] = [
            .Food : "Food",
            .Healthcare : "Healthcare",
            .Recreation : "Recreation",
            .Auto : "Auto",
            .Bills : "Bills",
            .Travel : "Travel",
            .Shopping : "Shops",
            .PersonalCare : "PersonalCare",
            .HomeImprovement : "HomeImprovement",
            .Community :"Community",
            .Services : "Services",
            .Miscellaneous : "Miscellaneous",
            .CC : "Credit Card"
        ]
        
        static let colors: [Category: Color] = [
            .Food : teal,
            .Healthcare : indigo,
            .Recreation : Color(.systemPink),
            .Auto : blue,
            .Bills : Color(.systemOrange),
            .Travel : magenta,
            .Shopping : yellow,
            .PersonalCare : lightPurple,
            .HomeImprovement : darkPurple,
            .Community : magenta,
            .Services : green,
            .Miscellaneous : Color(.systemGray),
            .CC : darkPurple,
        ]
        
        static let iconNames: [Category: String] = [
            .Food : "cart.fill",
            .Healthcare : "cross.case.fill",
            .Recreation : "gamecontroller.fill",
            .Auto : "car.fill",
            .Bills : "house.fill",
            .Travel : "airplane",
            .Shopping : "bag.fill",
            .PersonalCare : "PersonalCare",
            .HomeImprovement : "house.fill",
            .Community :"person.3.fill",
            .Services : "wrench.fill",
            .Miscellaneous : "ellipsis.circle.fill",
            .CC : "creditcard.fill"
        ]
        
        var name: String {
            return Category.names[self]!
        }
        
        var key: String {
            return Category.keys[self]!
        }
        
        var color: Color {
            return Category.colors[self]!
        }
        
        var iconName: String {
            return Category.iconNames[self]!
        }
    }
    
}
