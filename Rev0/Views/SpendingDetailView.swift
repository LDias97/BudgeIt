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
    @ObservedObject var vm = SpendingViewModel()
    @State var auto: String = ""
    @State var food: String = ""
    @State var entertainment: String = ""
    @State var bills: String = ""
    @State var selector: categorySelector = .auto
    @State var num = 0
    @State var total = 100
    @State var spendingAuto = 20
    @State var spentOnEntertainment = 10
    @State var spentOnBills = 50
    @State var spentOnFood = 20

    
    var body: some View {
        ScrollView{
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
                                .padding(.top)
                        }
                        .padding(.leading, 15)
                        Spacer()
                        Text("Spending")                        .font(Font.custom("DIN Alternate Bold", size: 24))
                            .padding(.top)
                        Spacer()
                        Button(action: { print("dot menu clicked" )} ) {
                            Image(systemName: "ellipsis")
                                .imageScale(.large)
                                .rotationEffect(.degrees(90))
                                .foregroundColor(Color(.black))
                                .padding(.top)
                        }
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
        }
        .background(VStack(){
            Rectangle()
                .fill(Color(red: 240/255, green: 240/255, blue: 240/255))
        })
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
                    // Category Text
                    Text(selector.name)
                        .font(Font.custom("DIN Alternate Bold", size: 22))
                    Spacer()
                    // forward arrow
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
                Divider()
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 20)
            
            if(selector == .auto) {
                autoTransactions()
            } else if (selector == .food) {
                foodTransactions()
            } else if (selector == .entertainment) {
                enterTransactions()
            } else if (selector == .bills) {
                billsTransactions()
            }
        }
        
    }
    
}


struct foodTransactions : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body : some View {
        VStack() {
            ZStack(){
                VStack(spacing: 10){
                    // Transaction 1
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Market Basket")
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
                                Text("-$210.43")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Chick-Fil-A")
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
                                Text("-$21.23")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Yardhouse")
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
                                Text("-$35.73")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Augustas Subs & Salads")
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
                                Text("-$10.90")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Chipotle")
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
                                Text("-$17.87")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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

struct autoTransactions : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body : some View {
        VStack(){
            ZStack(){
                VStack(spacing: 10){
                    // Transaction 1
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.systemTeal))
                                .frame(width: 3, height: 20, alignment: .center)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Shell Gas")
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
                                Text("-$45.43")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(.systemTeal))
                                .frame(width: 3, height: 20, alignment: .center)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Mobil Gas")
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
                                Text("-$43.23")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                    
                    // Transaction 3
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.systemTeal))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Nissan Oil Change")
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
                                Text("-$65.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(.systemTeal))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Mobil Gas")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 2/21/21")
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
                                Text("-$44.90")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(.systemTeal))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Speedway Gas")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 2/10/21")
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
                                Text("-$37.87")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
            Text("Total This Month: $300.00")
                .font(Font.custom("DIN Alternate Bold", size: 20))
        }
    }
}

struct enterTransactions : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body : some View {
        VStack() {
            ZStack(){
                VStack(spacing: 10){
                    // Transaction 1
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.systemYellow))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Netflix")
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
                                Text("-$13.99")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(.systemYellow))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Disney Plus")
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
                                Text("-$6.99")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                    
                    // Transaction 3
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.systemYellow))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Amazon")
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
                                Text("-$65.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(.systemYellow))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Hulu")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 2/21/21")
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
                                Text("-$10.99")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(.systemYellow))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Best Buy")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 2/10/21")
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
                                Text("-$345.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
            Text("Total This Month: $245.67")
                .font(Font.custom("DIN Alternate Bold", size: 20))
        }
    }
}

struct billsTransactions : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body : some View {
        VStack() {
            ZStack(){
                VStack(spacing: 10){
                    // Transaction 1
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.systemPink))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("National Grid")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 3/17/21")
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
                                Text("-$143.99")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(.systemPink))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Water")
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
                                Text("-$200.67")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                    
                    // Transaction 3
                    HStack(){
                        HStack(){
                            Rectangle()
                                .foregroundColor(Color(.systemPink))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Electric")
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
                                Text("-$142.76")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(.systemPink))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Mortgage")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 2/21/21")
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
                                Text("-$2200.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
                                .foregroundColor(Color(.systemPink))
                                .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                            VStack(alignment: .leading, spacing:5) {
                                Text("Taxes")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .bold()
                                HStack(){
                                    Text("Bank of America - 2/10/21")
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
                                Text("-$1000.00")
                                    .font(Font.custom("DIN Alternate Bold", size: 14))
                                    .foregroundColor(.red)
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
            Text("Total This Month: $5000.00")
                .font(Font.custom("DIN Alternate Bold", size: 20))
        }
    }
}

struct SpendingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingDetailView()
    }
}
