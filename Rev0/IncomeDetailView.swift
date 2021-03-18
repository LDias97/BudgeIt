//
//  IncomeDetailView.swift
//  Rev0
//
//  Created by Luann Dias on 3/6/21.
//


import SwiftUI

enum incomeSelector : Int {
    case payment
    case salary
    
    static let names: [incomeSelector: String] = [
        .payment : "Payment",
        .salary : "Salary"
    ]
    
    static let percentages: [incomeSelector: CGFloat] = [
        .payment: 0.3,
        .salary: 0.7,
    ]
    
    static let start: [incomeSelector: CGFloat] = [
        .payment: 0.0,
        .salary: 0.3,
    ]
    
    static let end: [incomeSelector: CGFloat] = [
        .payment: 0.3,
        .salary: 1.0,
    ]

    var name: String {
        return incomeSelector.names[self]!
    }
    var percentage: CGFloat {
        return incomeSelector.percentages[self]!
    }
    var start: CGFloat {
        return incomeSelector.start[self]!
    }
    var end: CGFloat {
        return incomeSelector.end[self]!
    }
}

struct IncomeDetailView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var selector: incomeSelector = .payment
    @State var num = 0

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
                    Text("Income")                        .font(Font.custom("DIN Alternate Bold", size: 24))
                    Spacer()
                    Button(action: { print("dot menu clicked" )} ) {
                        Image(systemName: "ellipsis")
                            .imageScale(.large)
                            .rotationEffect(.degrees(90))
                            .foregroundColor(Color(.black))
                    }
                    .padding(.trailing, 15)
                }
                IncomePieView(selector: $selector)
                    .padding(.top, 30)
                    .animation(Animation.interactiveSpring())
                Spacer()
                IncomeTableView(selector: $selector)
                    .padding(.top, 30)
            }
            .padding(.top, 20)
        }
    }
    
}

struct IncomePieView : View {
    @Binding var selector: incomeSelector

    var body : some View {
        ZStack(){
            Circle()
                .trim(from: incomeSelector.payment.start, to: incomeSelector.payment.end)
                .stroke(Color(.green), lineWidth: selector.rawValue == 0 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: incomeSelector.salary.start, to: incomeSelector.salary.end)
                .stroke(Color(.systemGreen), lineWidth: selector.rawValue == 1 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            VStack(){
                Text(String(format: "%.0f", selector.percentage*100) + "%")
                    .font(Font.custom("DIN Alternate Bold", size: 50))
            }
        }
    }
}

struct IncomeTableView : View {
    @Binding var selector: incomeSelector
    @State var num = 0
    
    var body : some View {
        ZStack(){
            Rectangle()
                .fill(Color.white)
                .frame(width: 400, height: 500)
            VStack(){
                HStack(){
                    // backward arrow
                    Button(action: {
                        num = (num == 1 ? num + 1 : num - 1)
                        switch(abs(num)%2){
                        case 0: selector = .payment
                        case 1: selector = .salary
                        default: fatalError("cannot be here")
                        }
                    } ) {
                        Image(systemName: "chevron.backward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    .padding(.leading, 15)
                    Spacer()
                    // Category Text
                    Text(selector.name)
                        .font(Font.custom("DIN Alternate Bold", size: 22))
                    Spacer()
                    // forward arrow
                    Button(action: {
                        num = (num == 1 ? num - 1 : num + 1)
                        switch(abs(num)%2){
                        case 0: selector = .payment
                        case 1: selector = .salary
                        default: fatalError("cannot be here")
                        }
                    } ) {
                        Image(systemName: "chevron.forward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    .padding(.trailing, 15)
                }
                Divider()
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 20)
            
            if(selector == .salary) {
                salaryIncomes()
            } else if(selector == .payment){
                paymentDeposits()
            }
        }
    }
    
}

struct salaryIncomes : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body : some View {
        VStack() {
            ZStack(){
                VStack(spacing: 10){
                    // Transaction 1
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.systemGreen))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Work")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 3/15/21")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.leading, 5)
                        }
                        Spacer()
                        VStack(spacing: 5){
                            HStack(){
                                Spacer()
                                Text("$1200.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.green)
                                    .bold()
                            }
                            HStack(){
                                Spacer()
                                Text("Pending")
                                    .font(Font.custom("DIN Alternate Bold", size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 1)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                    
                    // Transaction 2
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.systemGreen))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Work")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 3/10/21")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.leading, 5)
                        }
                        Spacer()
                        VStack(spacing: 5){
                            HStack(){
                                Spacer()
                                Text("$1200.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.green)
                                    .bold()
                            }
                            HStack(){
                                Spacer()
                                Text("Pending")
                                    .font(Font.custom("DIN Alternate Bold", size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 1)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                    
                    // Transaction 3
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.systemGreen))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Work")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 3/8/21")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.leading, 5)
                        }
                        Spacer()
                        VStack(spacing: 5){
                            HStack(){
                                Spacer()
                                Text("$1200.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.green)
                                    .bold()
                            }
                            HStack(){
                                Spacer()
                                Text("Processed")
                                    .font(Font.custom("DIN Alternate Bold", size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 1)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                    
                    // Transaction 4
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.systemGreen))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Work")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 3/7/21")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.leading, 5)
                        }
                        Spacer()
                        VStack(spacing: 5){
                            HStack(){
                                Spacer()
                                Text("$1300.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.green)
                                    .bold()
                            }
                            HStack(){
                                Spacer()
                                Text("Processed")
                                    .font(Font.custom("DIN Alternate Bold", size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 1)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                    
                    // Transaction 5
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.systemGreen))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Work")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 3/1/21")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.leading, 5)
                        }
                        Spacer()
                        VStack(spacing: 5){
                            HStack(){
                                Spacer()
                                Text("$1250.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.green)
                                    .bold()
                            }
                            HStack(){
                                Spacer()
                                Text("Processed")
                                    .font(Font.custom("DIN Alternate Bold", size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 1)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                }
            }
            Text("Total This Month: $6150.00")
                .font(Font.custom("DIN Alternate Bold", size: 20))
        }
        
    }
}

struct paymentDeposits : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body : some View {
        VStack() {
            ZStack(){
                VStack(spacing: 10){
                    // Transaction 1
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.green))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Venmo")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 3/15/21")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.leading, 5)
                        }
                        Spacer()
                        VStack(spacing: 5){
                            HStack(){
                                Spacer()
                                Text("$35.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(Color(.systemGreen))
                                    .bold()
                            }
                            HStack(){
                                Spacer()
                                Text("Pending")
                                    .font(Font.custom("DIN Alternate Bold", size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 1)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                    
                    // Transaction 2
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.green))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("ATM Deposit")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 3/10/21")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.leading, 5)
                        }
                        Spacer()
                        VStack(spacing: 5){
                            HStack(){
                                Spacer()
                                Text("$120.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(Color(.systemGreen))
                                    .bold()
                            }
                            HStack(){
                                Spacer()
                                Text("Pending")
                                    .font(Font.custom("DIN Alternate Bold", size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 1)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                    
                    // Transaction 3
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.green))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Venmo")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 3/8/21")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.leading, 5)
                        }
                        Spacer()
                        VStack(spacing: 5){
                            HStack(){
                                Spacer()
                                Text("$15.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(Color(.systemGreen))
                                    .bold()
                            }
                            HStack(){
                                Spacer()
                                Text("Processed")
                                    .font(Font.custom("DIN Alternate Bold", size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 1)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                    
                    // Transaction 4
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.green))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Mobile Check Deposit")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 3/7/21")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.leading, 5)
                        }
                        Spacer()
                        VStack(spacing: 5){
                            HStack(){
                                Spacer()
                                Text("$1400.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(Color(.systemGreen))
                                    .bold()
                            }
                            HStack(){
                                Spacer()
                                Text("Processed")
                                    .font(Font.custom("DIN Alternate Bold", size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 1)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                    
                    // Transaction 5
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.green))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("ATM Deposit")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 3/1/21")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.leading, 5)
                        }
                        Spacer()
                        VStack(spacing: 5){
                            HStack(){
                                Spacer()
                                Text("$60.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(Color(.systemGreen))
                                    
                                    .bold()
                            }
                            HStack(){
                                Spacer()
                                Text("Processed")
                                    .font(Font.custom("DIN Alternate Bold", size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 1)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                }
            }
            Text("Total This Month: $296.16")
                .font(Font.custom("DIN Alternate Bold", size: 20))
        }
        
    }
}

struct IncomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeDetailView()
    }
}

