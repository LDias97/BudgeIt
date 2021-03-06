//
//  BudgetDetailView.swift
//  Rev0
//
//  Created by Luann Dias on 3/3/21.
//

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
// Need to align bars to the bottom

struct BarChartView: View {
    
    let months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    var body : some View {
        ScrollView(.horizontal){
            ZStack{
                HStack {
                    // ForEach loop for green bar
                    ForEach(0..<12) { income in
                        VStack{
                            HStack{
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: 40, height: 75)
                                    .ignoresSafeArea()
                                    //.padding(.bottom)
                                // Inner ForEach loop for blue bar
                                ForEach(0..<1) { spending in
                                    HStack{
                                        Rectangle()
                                            .fill(Color.blue)
                                            .frame(width: 40, height: 100)
                                            .ignoresSafeArea()
                                            .padding(.bottom)
                                    }
                                    //.padding(.bottom, 25)
                                }
                            }
                            .padding(20) // Distance between each month
                            .padding(.top, 50)
                            Text(months[income]) // Month labels (X-Axis)
                                .foregroundColor(.black)
                        }
                    }
                }
                // Grid Lines
//                ForEach(0..<5) { line in
//                    VStack{
//                        Path() { path in
//                            //path.move(to: CGPoint(x:20, y: 20))
//                            path.addLine(to: CGPoint(x: 300, y:20))
//                        }
//                        .stroke(Color.gray, lineWidth: 10)
//                    }
//                }
            }

        }
    }
}

struct BudgetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetDetailView()
    }
}
