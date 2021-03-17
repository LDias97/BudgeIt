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
                    Text("Spending").font(.title3).bold()
                    Spacer()
                    Button(action: { print("dot menu clicked" )} ) {
                        Image(systemName: "ellipsis")
                            .imageScale(.large)
                            .rotationEffect(.degrees(90))
                            .foregroundColor(Color(.black))
                    }
                    .padding(.trailing, 15)
                }
                    SpendingPieView(selector: $selector)
                        .padding(.top, 30)
                        .animation(Animation.interactiveSpring())
                Spacer()
                SpendingTableView(selector: $selector)
                    .padding(.top, 30)
            }
            .padding(.top, 20)
        }
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
                    .font(.largeTitle)
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
                        .font(.title3)
                        .bold()
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
        }
    }
    
}

struct SpendingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingDetailView()
    }
}
