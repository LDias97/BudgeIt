import SwiftUI

enum categorySelector : Int {
    case auto
    case entertainment
    case bills
    case food
    static let names: [categorySelector: String] = [
        .auto: "Auto & Transport",
        .entertainment: "Entertainment",
        .bills: "Bills",
        .food : "Food & Restaurants"
    ]
    static let percentages: [categorySelector: CGFloat] = [
        .auto: 0.3,
        .entertainment: 0.2,
        .bills: 0.2,
        .food : 0.3
    ]
    
    static let start: [categorySelector: CGFloat] = [
        .auto: 0,
        .entertainment: 0.3,
        .bills: 0.5,
        .food : 0.7
    ]
    
    static let end: [categorySelector: CGFloat] = [
        .auto: 0.3,
        .entertainment: 0.5,
        .bills: 0.7,
        .food : 1.0
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
    @State var selector: categorySelector = .auto
    
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
                .trim(from: categorySelector.auto.start, to: categorySelector.auto.end)
                .stroke(Color(.systemTeal), lineWidth: selector.rawValue == 0 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: categorySelector.entertainment.start, to: categorySelector.entertainment.end)
                .stroke(Color(.systemYellow), lineWidth: selector.rawValue == 1 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .trim(from: categorySelector.bills.start, to: categorySelector.bills.end)
                .stroke(Color(.systemPink), lineWidth: selector.rawValue == 2 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: categorySelector.food.start, to: categorySelector.food.end)
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
    
    var body : some View {
        ZStack(){
            Rectangle()
                .fill(Color.white)
                .frame(width: 400, height: 500)
            VStack(){
                SelectorBar(selector: $selector)
                Divider()
                if(selector == .auto) {
                    SpendingTable(color: Color(.blue))
                } else if (selector == .food) {
                    SpendingTable(color: Color(.systemTeal))
                } else if (selector == .entertainment) {
                    SpendingTable(color: Color(.systemYellow))
                } else if (selector == .bills) {
                    SpendingTable(color: Color(.systemPink))
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
                case 0: selector = .auto
                case 1: selector = .entertainment
                case 2: selector = .bills
                case 3: selector = .food
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
                case 0: selector = .auto
                case 1: selector = .entertainment
                case 2: selector = .bills
                case 3: selector = .food
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

struct SpendingTable : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userData: UserData
    @State var color: Color

    var body : some View {
        ScrollView{
        VStack() {
                ForEach(userData.spending) { transaction in
                    VStack(spacing: 10){
                        SpendingCell(name: transaction.name, amount: transaction.amount, pending: transaction.pending, date: transaction.date, color: color)
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
