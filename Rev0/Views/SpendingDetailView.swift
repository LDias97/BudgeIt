import SwiftUI

enum categorySelector : Int {
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
    
    
    static let names: [categorySelector: String] = [
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
    
    static let percentages: [categorySelector: CGFloat] = [
        .Auto: 0.3,
        .Recreation: 0.2,
        .Bills: 0.2,
        .Food : 0.3
    ]
    
    static let start: [categorySelector: CGFloat] = [
        .Auto: 0,
        .Recreation: 0.3,
        .Bills: 0.5,
        .Food : 0.7
    ]
    
    static let end: [categorySelector: CGFloat] = [
        .Auto: 0.3,
        .Recreation: 0.5,
        .Bills: 0.7,
        .Food : 1.0
    ]
    
    var name: String {
        return categorySelector.names[self]!
    }
    var percentage: CGFloat {
        return categorySelector.percentages[self]!
    }
    var start: CGFloat {
        return categorySelector.start[self]!
    }
    var end: CGFloat {
        return categorySelector.end[self]!
    }
}

struct SpendingDetailView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userData: UserData
    @State var selector: categorySelector = .Auto
    
    var body: some View {
            ZStack(){
                Rectangle()
                    .fill(grey)
                    .ignoresSafeArea()
                VStack(){
                    HStack(){
                        backButton(page: .page3)
                        .padding(.leading, 15)
                        Spacer()
                        Text("Spending")
                            .font(Font.custom("DIN Alternate Bold", size: 24))
                            .padding(.top)
                        Spacer()
                        ellipsisButton()
                        .padding(.trailing, 15)
                    }
                    SpendingPieView(selector: $selector)
                        .padding(.top, 50)
                        .animation(Animation.interactiveSpring())
                    Spacer()
                    SpendingTableView(selector: $selector)
                        .padding(.top, 50)
                }
                .padding(.top, 50)
            }
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct SpendingPieView : View {
    @Binding var selector: categorySelector
    
    var body : some View {
        ZStack(){
            Circle()
                .trim(from: categorySelector.Auto.start, to: categorySelector.Auto.end)
                .stroke(Color(.systemTeal), lineWidth: selector.rawValue == 0 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: categorySelector.Recreation.start, to: categorySelector.Recreation.end)
                .stroke(Color(.systemYellow), lineWidth: selector.rawValue == 1 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .trim(from: categorySelector.Bills.start, to: categorySelector.Bills.end)
                .stroke(Color(.systemPink), lineWidth: selector.rawValue == 2 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: categorySelector.Food.start, to: categorySelector.Food.end)
                .stroke(Color(.systemIndigo), lineWidth: selector.rawValue == 3 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            VStack(){
                Text(String(format: "%.0f", selector.percentage*100) + "%")
                    .font(Font.custom("DIN Alternate Bold", size: 50))
                    .foregroundColor(.black)
                    .padding(.leading)
            }
        }
    }
}

struct SpendingTableView : View {
    @Binding var selector: categorySelector
    @EnvironmentObject var userData: UserData
    
    var body : some View {
        ZStack(){
            Rectangle()
                .fill(Color.white)
                .frame(width: 400, height: 500)
            VStack(){
                SelectorBar(selector: $selector)
                Divider()
                ScrollView{
                VStack() {
                        ForEach(userData.spending) { transaction in
                            if(transaction.category!.name == selector.name){
                            VStack(spacing: 10){
                                SpendingCell(name: transaction.name, amount: transaction.amount, pending: transaction.pending, date: transaction.date, color: transaction.category!.color)
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
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 20)
        }
    }
}

struct SelectorBar: View {
    @Binding var selector: categorySelector
    @State var num = 0
    
    var body : some View {
        HStack(){
            Button(action: {
                num = (num == 3 ? num + 3 : num - 1)
                switch(abs(num)%4){
                case 0: selector = .Auto
                case 1: selector = .Recreation
                case 2: selector = .Bills
                case 3: selector = .Food
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
                num = (num == 3 ? num - 3 : num + 1)
                switch(abs(num)%4){
                case 0: selector = .Auto
                case 1: selector = .Recreation
                case 2: selector = .Bills
                case 3: selector = .Food
                default: fatalError("cannot be here")
                }
            } ) {
                Image(systemName: "chevron.forward")
                    .imageScale(.large)
                    .foregroundColor(Color(.black))
            }
            .padding(.trailing, 15)
        }
    }
}

struct SpendingCell: View {
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
                        .foregroundColor(red)
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

struct SpendingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingDetailView()
    }
}
