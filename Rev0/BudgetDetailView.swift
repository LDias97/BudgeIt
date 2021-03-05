//
//  BudgetDetailView.swift
//  Rev0
//
//  Created by Luann Dias on 3/3/21.
//

import Foundation
import SwiftUI
// import SpendingDetailView()


// TODO
// Need to create object of SpendingDetailView to use PieChart
// For each category, have settings (switchs, options, etc.) that allow the user to set their BudgeIt settings
// Let the user set a maximum amount to spend on each category every month and have BudgeIt give tips and averages
// Allow the user to set an option to round every transaction to the nearest dollar and deposit that difference onto a preferred savings account. For instance: If the user spent $24.85 on something, BudgeIt should be able to round that to 25.00 and deposit that difference of $0.15 into a "piggy bank" account. If this setting is turned on, it should be able to turn off by itself once the account reaches a very low balance to prevent it going negative and having overdraft fees.
// Show cash flow with bar charts, show two bars for each month within the past year (one for income and one for spent) from $0 - $10K

struct BudgetDetailView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var auto: String = ""
    @State var food: String = ""
    @State var entertainment: String = ""
    @State var bills: String = ""
    // var pieChart: SpendingDetailView

    var body: some View {
        ZStack(){
            Rectangle()
                .fill(Color(red: 240/255, green: 240/255, blue: 240/255))
                .ignoresSafeArea()
            VStack(){
                HStack(){
                    Button(action: { viewRouter.currentPage = .page3; } ) {
                        Image(systemName: "chevron.backward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    .padding(.leading, 15)
                    Spacer()
                    Text("BudgeIt").font(.title3).bold()
                    Spacer()
                    Button(action: { print("dot menu clicked" )} ) {
                        Image(systemName: "ellipsis")
                            .imageScale(.large)
                            .rotationEffect(.degrees(90))
                            .foregroundColor(Color(.black))
                    }
                    .padding(.trailing, 15)
                }
                BarChartView()
                Spacer()
                DetailView()
                    .padding(.top, 30)
            }
            .padding(.top, 20)
        }
    }
    

    
}

// Set the sizes for the bar chart depending on the amount of income and deposits.

struct BarChartView: View {
    var body : some View {
        ZStack(){
            HStack(){
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 100)
                    .ignoresSafeArea()
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 40, height: 75)
                    .ignoresSafeArea()
            }
        }
    }
}

struct BudgetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetDetailView()
    }
}
