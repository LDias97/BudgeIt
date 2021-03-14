import SwiftUI

enum categorySelectorText : Int {
    case auto
    case entertainment
    case bills
    case food
    static let mapper: [categorySelectorText: String] = [
        .auto: "Auto & Transport",
        .entertainment: "Entertainment",
        .bills: "Bills",
        .food : "Food & Restaurants"
    ]
    var string: String {
        return categorySelectorText.mapper[self]!
    }
}

struct SpendingDetailView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var auto: String = ""
    @State var food: String = ""
    @State var entertainment: String = ""
    @State var bills: String = ""
    @State var selector: categorySelectorText = .auto
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
                Spacer()
                SpendingTableView(selector: $selector)
                    .padding(.top, 30)
            }
            .padding(.top, 20)
        }
    }
    
}

struct SpendingPieView : View {
    @Binding var selector: categorySelectorText

    var body : some View {
        
        ZStack(){
            Circle()
                .trim(from: 0.0, to: 0.3)
                .stroke(Color(.systemTeal), lineWidth: selector.rawValue == 0 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0.3, to: 0.5)
                .stroke(Color(.systemYellow), lineWidth: selector.rawValue == 1 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0.5, to: 0.7)
                .stroke(Color(.systemPink), lineWidth: selector.rawValue == 2 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0.7, to: 1.0)
                .stroke(Color(.systemIndigo), lineWidth: selector.rawValue == 3 ? 50 : 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            VStack(){
                Text("28%")
                    .font(.title)
            }
        }
    }
}

struct SpendingTableView : View {
    @Binding var selector: categorySelectorText
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
                    Text(selector.string)
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
