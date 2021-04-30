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
    @EnvironmentObject var userData: UserData
    @State var selector: incomeSelector = .payment
    
    var body: some View {
        ZStack(){
            Rectangle()
                .fill(grey)
                .ignoresSafeArea()
            VStack(){
                HStack(){
                    BackButton(page: .page3)
                        .padding(.leading, 15)
                    Spacer()
                    Text("Income")
                        .font(Font.custom("DIN Alternate Bold", size: 24))
                    Spacer()
                    EllipsisButton()
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
                    Text(selector.name)
                        .font(Font.custom("DIN Alternate Bold", size: 22))
                    Spacer()
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
                if(selector == .payment) {
                    IncomeTable(color: Color(.green))
                } else if(selector == .salary){
                    IncomeTable(color: Color(.systemGreen))
                }
                Spacer()
//                Text("Total This Month: $6150.00")
//                    .font(Font.custom("DIN Alternate Bold", size: 20))
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 20)
            .padding(.bottom, 20)
        }
    }
}

struct IncomeTable : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userData: UserData
    @State var color: Color
    
    var body : some View {
        ScrollView{
            VStack() {
                ForEach(userData.income) { transaction in
                    VStack(spacing: 10){
                        IncomeCell(name: transaction.name, amount: transaction.amount, pending: transaction.pending, date: transaction.date, color: color)
                        Rectangle()
                            .fill(Color(.systemGray6))
                            .frame(height: 1)
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                    }
                }
            }
        }
    }
}

struct IncomeCell: View {
    @State var name: String
    @State var amount: Double
    @State var pending: Bool
    @State var date: String
    @State var color: Color
    
    var body : some View {
        HStack(){
            HStack(){
                Rectangle()
                    .foregroundColor(color)
                    .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10.0)
                
                VStack(alignment: .leading, spacing:5) {
                    Text(name)
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
                    Text("$\(amount * (-1), specifier: "%.2f")")
                        .font(Font.custom("DIN Alternate Bold", size: 14))
                        .foregroundColor(Color(.systemGreen))
                        .bold()
                }
                HStack(){
                    Spacer()
                    pending ?
                        Text(date)
                        .font(Font.custom("DIN Alternate Bold", size: 12))
                        .foregroundColor(.gray)
                        :
                        Text("Pending")
                        .font(Font.custom("DIN Alternate Bold", size: 12))
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.leading, 30)
        .padding(.trailing, 30)
        .padding(.top, 20)
    }
}

struct IncomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeDetailView()
    }
}

