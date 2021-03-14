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

// The values of the pie chart should change and rotate after clicking each chevron button and the list of options to see
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
                    Text("Income").font(.title3).bold()
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
                .stroke(Color(.systemTeal), lineWidth: selector.rawValue == 0 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: incomeSelector.salary.start, to: incomeSelector.salary.end)
                .stroke(Color(.systemYellow), lineWidth: selector.rawValue == 1 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            VStack(){
                Text(String(format: "%.0f", selector.percentage*100) + "%")
                    .font(.title)
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
                        .font(.title3)
                        .bold()
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
        }
    }
    
}


struct IncomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeDetailView()
    }
}

