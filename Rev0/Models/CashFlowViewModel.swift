//
//  CashFlowViewModel.swift
//  Rev0
//
//  Created by Luann Dias on 4/19/21.
//

//import Foundation
//import SwiftUI
//import FirebaseFunctions
//
//final class CashFlowViewModel: ObservableObject, Identifiable {
//    
//    
//    //@Published var months: Int
//    let monthNames: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
//    @EnvironmentObject var userData: UserData
//    @Published var months: [Month]
//    
//    init(userData: UserData){
//        for i in 1..<monthNames.count {
//            //userData.getBalanceByMonth(startYear: 2020, startMonth: i, startDay: 1)
//            months = [Month(monthName: monthNames[i], income: userData.monthlyIncome, spending: userData.monthlySpending, difference: userData.monthlyDifference)]
//        }
//    }
//    
//    struct Month: Hashable, Identifiable {
//        var id = UUID()
//        var monthName: String
//        var income: Double
//        var spending: Double
//        var difference: Double
//        
//    }
//}

//    @Published var currentBalance: Double = 0.0
//    @Published var difference: Double = 0.0
//    @Published var income: Double = 0.0
//    @Published var spending: Double = 0.0
//    @Published var loaded: Bool = false
//
//    //@Published var months: MonthSelector
//
//
//    init(userData: UserData){
//
//        userData.getBalanceByMonth(startYear: 2020, startMonth: 4, startDay: 1)
//
//        self.currentBalance = userData.netWorth
//        self.income = userData.monthlyIncome * (-1)
//        self.spending = userData.monthlySpending
//        self.difference = self.income - self.spending
//        self.loaded = userData.hasLoaded
//    }

