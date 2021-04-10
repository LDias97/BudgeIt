import SwiftUI
import Firebase

enum MonthSelector : Int {
    case Jan
    case Feb
    case Mar
    case Apr
    case May
    case Jun
    case Jul
    case Aug
    case Sep
    case Oct
    case Nov
    case Dec
    
    static let abreviatedNames: [MonthSelector: String] = [
        .Jan: "Jan",
        .Feb: "Feb",
        .Mar: "Mar",
        .Apr: "Apr",
        .May: "May",
        .Jun: "Jun",
        .Jul: "Jul",
        .Aug: "Aug",
        .Sep: "Sep",
        .Oct: "Oct",
        .Nov: "Nov",
        .Dec: "Dec"
    ]
    
    static let fullNames: [MonthSelector: String] = [
        .Jan: "January",
        .Feb: "February",
        .Mar: "March",
        .Apr: "April",
        .May:  "May",
        .Jun: "June",
        .Jul: "July",
        .Aug: "August",
        .Sep: "September",
        .Oct: "October",
        .Nov: "November",
        .Dec: "December"
    ]
    
    var name: String {
        return MonthSelector.abreviatedNames[self]!
    }
    var fullName: String {
        return MonthSelector.fullNames[self]!
    }
}

struct DashboardView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userData: UserData
    @ObservedObject var budgetViewModel = BudgetViewModel()
    @State var showMenu = false
    @State var editBudgets = false
    @State var  viewCharts = false

    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        GeometryReader { geometry in
            ZStack(){
                ScrollView{
                    ZStack(alignment:.top){
                        Rectangle()
                            .fill(Color(.systemGray6))
                        Image("header")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.bottom, geometry.size.height+350)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        VStack(spacing: 30){
                            ZStack(alignment:.top){
                                VStack(){
                                    HStack(){
                                        Button(action: { withAnimation(.default) {
                                            self.showMenu.toggle(); }
                                        } ) {
                                            Image(systemName: "line.horizontal.3")
                                                .imageScale(.large)
                                                .foregroundColor(Color(.white))
                                        }
                                        .padding(.leading, 30)
                                        Spacer()
                                        Button(action: { withAnimation(.default) {
                                            self.showMenu.toggle(); }
                                        } ) {
                                            Image(systemName: "bell.badge")
                                                .imageScale(.large)
                                                .foregroundColor(Color(.white))
                                        }
                                        .padding(.trailing, 30)
                                    }
                                    HStack(){
                                        Text("Dashboard")
                                            .font(.custom("DIN Alternate Bold", size: 30))
                                            .foregroundColor(Color(.white))
                                        Spacer()
                                    }
                                    .padding(.leading, 30)
                                    .padding(.top, 20)
                                }
                                .padding(.top, 20)
                                NetWorthCardView(viewModel: NetWorthViewModel(userData: userData))
                            }
                            .padding(.top, 44)
                            BudgetCardView(editBudgets: $editBudgets, limits: budgetViewModel.limits)
                            //                            .onTapGesture {
                            //                                viewRouter.currentPage = .page5;
                            //                            }
                            BarChartDashView(viewCharts: $viewCharts)
                            SpendingCardView()
                                .onTapGesture {
                                    withAnimation{viewRouter.currentPage = .page4;}
                                }
                            IncomeCardView()
                                .foregroundColor(.black)
                                .onTapGesture {
                                    withAnimation{viewRouter.currentPage = .page6;}
                                }
                                .padding(.bottom, 15)
                        }
                    }
                }
                .background(
                    Rectangle()
                        .fill(Color(.systemGray6))
                )
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                HStack(){
                    MenuView(showMenu: $showMenu)
                        .offset(x: self.showMenu ? 0 : 0 - (UIScreen.main.bounds.width))
                        .background(Color.primary.opacity(self.showMenu ? 0.6 : 0))
                        .ignoresSafeArea()
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .gesture(drag)
        .gesture(DragGesture(minimumDistance: 0).onEnded({ (value) in
            if (value.location.x > UIScreen.main.bounds.width*0.6){
                withAnimation {
                    self.showMenu = false
                }
            }
        }))
    }
}

struct NetWorthCardView: View {
    @ObservedObject var viewModel: NetWorthViewModel
    @State var degrees: Double = 180
    
    var body: some View {
        ZStack{
            if viewModel.currentBalance == 0.0 {
                GreetingCardView()
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .padding(.top, 120)
            }
            else{
                ZStack(){
                    Card(width: 375, height: 150)
                    HStack(){
                        VStack(alignment: .leading, spacing: 15){
                            Text("Net Worth")
                                .font(.custom("DIN Alternate Bold", size: 20))
                            Text("$\(viewModel.currentBalance,specifier: "%.2f")")
                                .foregroundColor(green)
                                .font(.custom("DIN Alternate Bold", size: 35))
                            viewModel.difference >= 0 ?
                                Text("+$\(abs(viewModel.difference),specifier: "%.2f") this month")
                                .foregroundColor(viewModel.difference > 0 ? green : red)
                                .font(.custom("DIN Alternate Bold", size: 14))
                                :
                                Text("-$\(abs(viewModel.difference),specifier: "%.2f") this month")
                                .foregroundColor(viewModel.difference > 0 ? green : red)
                                .font(.custom("DIN Alternate Bold", size: 14))
                        }
                        .padding(.leading, 50)
                        Spacer()
                        HStack(){
                            VStack(){
                                Spacer()
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(green)
                                Spacer()
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(red)
                                Spacer()
                            }
                            VStack(){
                                Spacer()
                                Text("Earned")
                                    .foregroundColor(Color(.systemGray))
                                    .font(.custom("DIN Alternate Bold", size: 16))
                                Text("$\(viewModel.earned,specifier: "%.2f")")
                                    .font(.custom("DIN Alternate Bold", size: 20))
                                Spacer()
                                Text("Spent")
                                    .foregroundColor(Color(.systemGray))
                                    .font(.custom("DIN Alternate Bold", size: 16))
                                Text("$\(viewModel.spent,specifier: "%.2f")")
                                    .font(.custom("DIN Alternate Bold", size: 20))
                                Spacer()
                            }
                        }
                        .padding(.trailing, 50)
                    }
                }
                .onAppear(){ withAnimation { self.degrees += 180;} }
                .padding(.top, 120)
            }
        }
        .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut)
    }
}

struct GreetingCardView: View{
    
    var body: some View {
        ZStack(){
            Card(width: 375, height: 150)
            Text("Good evening User!")
                .font(.custom("DIN Alternate Bold", size: 28))
                .foregroundColor(.green)
        }
    }
}

struct BudgetCardView : View {
    @ObservedObject var viewModel = BudgetViewModel()
    @Binding var editBudgets: Bool
    @State var degrees: Double = 180
    @State var limits: [CGFloat]
    
    var body: some View {
        
        ZStack(alignment: .top){
            if !editBudgets {
                ZStack{
                    Card(width: 375, height: 350)
                    VStack(spacing: 15){
                        HStack(){
                            Text("Budgets")
                                .font((Font.custom("DIN Alternate Bold", size: 20)))
                            Spacer()
                            Button(action: { self.editBudgets = true;
                                    withAnimation { self.degrees += 180;} }) {
                                Image(systemName: "pencil")
                                    .imageScale(.medium)
                                    .foregroundColor(Color(.black))
                            }
                        }
                        .padding(.leading, 50)
                        .padding(.trailing, 40)
                        VStack(){
                            ForEach(viewModel.budgets) { budget in
                                VStack(){
                                    HStack{
                                        ProgressCircle(percentage: budget.percentage, color: budget.color, iconName: budget.iconName)
                                        VStack(spacing: 5){
                                            HStack(){
                                                Text("\(budget.category)")
                                                    
                                                    .font((Font.custom("DIN Alternate Bold", size: 14)))
                                                    .bold()
                                                Spacer()
                                            }
                                            HStack(){
                                                Text("$\(budget.limit - budget.spent, specifier: "%.2f") left")
                                                    .font((Font.custom("DIN Alternate Bold", size: 12)))
                                                    .foregroundColor(.gray)
                                                Spacer()}
                                        }
                                        Spacer()
                                        VStack(spacing: 5){
                                            HStack(){
                                                Spacer()
                                                Text("$\(budget.limit, specifier: "%.2f")")
                                                    .font((Font.custom("DIN Alternate Bold", size: 14)))
                                                    .foregroundColor(Color(.blue))
                                                    .bold()
                                            }
                                            HStack(){
                                                Spacer()
                                                Text("$\(budget.spent, specifier: "%.2f") of $\(budget.limit, specifier: "%.2f")")
                                                    .font((Font.custom("DIN Alternate Bold", size: 12)))
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                    if(budget != viewModel.budgets[viewModel.budgets.count-1]){
                                        Divider()
                                            .padding(.top, 5)
                                            .padding(.bottom, 5)
                                    }
                                }
                            }
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                        }
                        .padding(.top, 20)
                    }
                }
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            
            else {
                ZStack(alignment: .top){
                    Card(width: 375, height: 350)
                    VStack(spacing: 10){
                        HStack(){
                            Text("Edit Budgets")
                                .font((Font.custom("DIN Alternate Bold", size: 20)))
                            Spacer()
                            Button(action: { viewModel.updateLimits(limits: limits); self.editBudgets = false;
                                    withAnimation { self.degrees -= 180;} }) {
                                Image(systemName: "checkmark")
                                    .imageScale(.medium)
                                    .foregroundColor(Color(.black))
                            }
                        }
                        .padding(.trailing, 40)
                        .padding(.leading, 50)
                        .padding(.top, 30)
                        VStack(){
                            ForEach(viewModel.budgets.indices) { index in
                                VStack(spacing: 5){
                                    HStack(){
                                        ZStack{
                                            Circle()
                                                .stroke(Color(.white), lineWidth: 3)
                                                .frame(width: 40, height:40)
                                            Image(systemName: viewModel.budgets[index].iconName)
                                                .foregroundColor(viewModel.budgets[index].color)
                                        }
                                        Text("\(viewModel.budgets[index].category)")
                                            .font((Font.custom("DIN Alternate Bold", size: 14)))
                                        Spacer()
                                        TextField("$\(viewModel.budgets[index].limit, specifier: "%.2f")", value: $limits[index], formatter: NumberFormatter())
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .fixedSize()
                                            .multilineTextAlignment(.trailing)
                                    }
                                    if(viewModel.budgets[index] != viewModel.budgets[viewModel.budgets.count-1]){
                                        Divider()
                                            .padding(.top, 5)
                                            .padding(.bottom, 5)
                                    }
                                }
                            }
                        }
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                        .padding(.top, 30)
                    }
                }
            }
        }
        .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut)
    }
}

struct BarChartDashView: View {
    @State var selectedMonth: Int = 0
    //    var incomeValue: Double = 0.0
    //    var spendingValue: Double = 0.0
    //    var difference: Double = 0.0 // income - spending, cast to string
    //    var id: Int = 0
    @Binding var viewCharts: Bool
    @State var degrees: Double = 180
    
    var body : some View {
        ZStack() {
            if !viewCharts {
                ZStack(){
                    Card(width: 375, height: 450)
                    VStack() {
                        HStack(){
                            Text("Financial Summary")
                                .font(Font.custom("DIN Alternate Bold", size: 20))
                            Spacer()
                            Button(action: {self.viewCharts = true;
                                    withAnimation { self.degrees += 180;} }) {
                                Image(systemName: "chevron.forward")
                                    .imageScale(.medium)
                                    .foregroundColor(Color(.black))
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.top, 20)
                        BarChartView(selectedMonth: $selectedMonth)
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                } // End of inner ZStack
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            } // End of if statement
            else {
                ZStack(alignment: .top){
                    Card(width: 375, height: 450)
                    VStack(spacing: 10) {
                        HStack(){
                            Button(action: {self.viewCharts = false;
                                    withAnimation { self.degrees -= 180;} }) {
                                Image(systemName: "chevron.backward")
                                    .imageScale(.medium)
                                    .foregroundColor(Color(.black))
                            }
                            Spacer()
                            Text("Categories")
                                .font(Font.custom("DIN Alternate Bold", size: 20))
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.top, 20)
                        CategoryCharts()
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                } // End of inner ZStack
            } // End of else statement
        } // End of outer ZStack
        .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut)
    }
}

struct CategoryCharts: View {
    
    @State var i = 0
    @State var j = 3
    @State var wmy = 1
    //@Binding var viewCharts: Bool
    @State var degrees: Double = 180
    
    var body: some View {
        VStack(){
            HStack(spacing: 15){
                Button(action: {wmy = 0;}){
                    ZStack{
                        Rectangle()
                            .fill(wmy == 0 ?
                                    (LinearGradient(gradient: Gradient(colors: [ darkPurple,Color(.blue)]), startPoint: .trailing, endPoint: .leading))
                                    :
                                    (LinearGradient(gradient: Gradient(colors: [ Color(.systemGray5)]), startPoint: .trailing, endPoint: .leading)))
                            .frame(width: 75, height: 40)
                            .cornerRadius(30)
                        Text("Week")
                            .foregroundColor(wmy == 0 ? Color(.white) : Color(.systemGray2))
                            .font((Font.custom("DIN Alternate Bold", size: 14)))
                    }
                }
                Button(action: {wmy = 1;}){
                    ZStack{
                        Rectangle()
                            .fill(wmy == 1 ?
                                    (LinearGradient(gradient: Gradient(colors: [ darkPurple,Color(.blue)]), startPoint: .trailing, endPoint: .leading))
                                    :
                                    (LinearGradient(gradient: Gradient(colors: [ Color(.systemGray5)]), startPoint: .trailing, endPoint: .leading)))
                            .frame(width: 75, height: 40)
                            .cornerRadius(30)
                        Text("Month")
                            .foregroundColor(wmy == 1 ? Color(.white) : Color(.systemGray2))
                            .font((Font.custom("DIN Alternate Bold", size: 14)))
                    }
                }
                Button(action: {wmy = 2;}){
                    ZStack{
                        Rectangle()
                            .fill(wmy == 2 ?
                                    (LinearGradient(gradient: Gradient(colors: [ darkPurple,Color(.blue)]), startPoint: .trailing, endPoint: .leading))
                                    :
                                    (LinearGradient(gradient: Gradient(colors: [ Color(.systemGray5)]), startPoint: .trailing, endPoint: .leading)))
                            .frame(width: 75, height: 40)
                            .cornerRadius(30)
                        Text("Year")
                            .foregroundColor(wmy == 2 ? Color(.white) : Color(.systemGray2))
                            .font((Font.custom("DIN Alternate Bold", size: 14)))
                    }
                }
            }
            Spacer()
            HStack(spacing: 40){
                Button(action: { print("Back clicked");}){
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color(.systemGray))
                }
                VStack(){
                    Spacer()
                    ZStack(alignment: .bottom){
                        HStack(alignment: .bottom, spacing: 5){
                            Rectangle()
                                .frame(width: 7, height: 100)
                                .foregroundColor(Color(.systemGray5))
                            Rectangle()
                                .frame(width: 7, height:130)
                                .foregroundColor(Color(.systemGray5))
                            Rectangle()
                                .frame(width: 7, height: 50)
                                .foregroundColor(Color(.systemGray5))
                            Rectangle()
                                .frame(width: 7, height: 70)
                                .foregroundColor(Color(.systemGray5))
                        }
                        HStack(alignment: .bottom, spacing: 5){
                            Rectangle()
                                .frame(width: 7, height: 60)
                                .foregroundColor(Color(.blue))
                            Rectangle()
                                .frame(width: 7, height: 60)
                                .foregroundColor(Color(.systemTeal))
                            Rectangle()
                                .frame(width: 7, height: 30)
                                .foregroundColor(Color(.systemPink))
                            Rectangle()
                                .frame(width: 7, height: 50)
                                .foregroundColor(Color(.systemOrange))
                        }
                    }
                    .padding(.bottom, 10)
                    Text("Mar")
                        .font((Font.custom("DIN Alternate Bold", size: 16)))
                }
                VStack(){
                    Spacer()
                    ZStack(alignment: .bottom){
                        HStack(alignment: .bottom, spacing: 5){
                            Rectangle()
                                .frame(width: 7, height: 80)
                                .foregroundColor(Color(.systemGray5))
                            Rectangle()
                                .frame(width: 7, height: 100)
                                .foregroundColor(Color(.systemGray5))
                            Rectangle()
                                .frame(width: 7, height: 120)
                                .foregroundColor(Color(.systemGray5))
                            Rectangle()
                                .frame(width: 7, height: 90)
                                .foregroundColor(Color(.systemGray5))
                        }
                        HStack(alignment: .bottom, spacing: 5){
                            Rectangle()
                                .frame(width: 7, height: 70)
                                .foregroundColor(Color(.blue))
                            Rectangle()
                                .frame(width: 7, height: 60)
                                .foregroundColor(Color(.systemTeal))
                            Rectangle()
                                .frame(width: 7, height: 110)
                                .foregroundColor(Color(.systemPink))
                            Rectangle()
                                .frame(width: 7, height: 40)
                                .foregroundColor(Color(.systemOrange))
                        }
                    }
                    .padding(.bottom, 10)
                    Text("Apr")
                        .font((Font.custom("DIN Alternate Bold", size: 16)))
                }
                VStack(){
                    Spacer()
                    ZStack(alignment: .bottom){
                        HStack(alignment: .bottom, spacing: 5){
                            Rectangle()
                                .frame(width: 7, height: 100)
                                .foregroundColor(Color(.systemGray5))
                            Rectangle()
                                .frame(width: 7, height: 120)
                                .foregroundColor(Color(.systemGray5))
                            Rectangle()
                                .frame(width: 7, height: 90)
                                .foregroundColor(Color(.systemGray5))
                            Rectangle()
                                .frame(width: 7, height: 100)
                                .foregroundColor(Color(.systemGray5))
                        }
                        HStack(alignment: .bottom, spacing: 5){
                            Rectangle()
                                .frame(width: 7, height: 85)
                                .foregroundColor(Color(.blue))
                            Rectangle()
                                .frame(width: 7, height: 70)
                                .foregroundColor(Color(.systemTeal))
                            Rectangle()
                                .frame(width: 7, height: 45)
                                .foregroundColor(Color(.systemPink))
                            Rectangle()
                                .frame(width: 7, height: 80)
                                .foregroundColor(Color(.systemOrange))
                        }
                    }
                    .padding(.bottom, 10)
                    Text("May")
                        .font((Font.custom("DIN Alternate Bold", size: 16)))
                }
                Button(action: { print("forward clicked");}){
                    Image(systemName: "chevron.forward")
                        .foregroundColor(Color(.systemGray))
                }
        
            }
            .padding(.bottom, 20)
            Spacer()
            Text("2021")
                .font((Font.custom("DIN Alternate Bold", size: 24)))
        }
        .padding(.top, 30)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .padding(.bottom, 20)
    }
}

struct SpendingCardView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ZStack(alignment: .top){
            Card(width: 375, height: 300)
            VStack(spacing: 10){
                HStack(){
                    Text("Spending")
                        .font(Font.custom("DIN Alternate Bold", size: 20))
                    Spacer()
                    Button(action:{
                            viewRouter.currentPage = .page4;
                            print("SpendingDetailView clicked")} )
                    {
                        Image(systemName: "chevron.forward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    .padding(.trailing, 40)
                }
                .padding(.leading, 50)
                .padding(.top, 20)
                ScrollView {
                    ForEach(userData.spending) { transaction in
                        HStack(){
                            HStack(){
                                Rectangle()
                                    .foregroundColor(transaction.category!.color)
                                    .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(10.0)
                                VStack(alignment: .leading, spacing:5){
                                    Text(transaction.name)
                                        .font(Font.custom("DIN Alternate Bold", size: 14))
                                        .bold()
                                    HStack(){
                                        Text("Bank of America")
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
                                    Text("$\(transaction.amount, specifier: "%.2f")")
                                        .font(Font.custom("DIN Alternate Bold", size: 14))
                                        .foregroundColor(red)
                                        .bold()
                                }
                                HStack(){
                                    Spacer()
                                    transaction.pending ?
                                        Text("\(transaction.date)")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                        :
                                        Text("Pending")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        Divider()
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                }
                .frame(width: 375, height: 240)
            }
        }
    }
}

struct IncomeCardView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ZStack(alignment: .top){
            Card(width: 375, height: 300)
            VStack(spacing: 10){
                HStack(){
                    Text("Income")
                        .font(Font.custom("DIN Alternate Bold", size: 20))
                    Spacer()
                    Button(action:{viewRouter.currentPage = .page6;})
                    {
                        Image(systemName: "chevron.forward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    .padding(.trailing, 40)
                }
                .padding(.leading, 50)
                .padding(.top, 20)
                ScrollView {
                    ForEach(userData.income) { transaction in
                        HStack(){
                            HStack(){
                                Rectangle()
                                    .foregroundColor(Color(.systemGreen))
                                    .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(10.0)
                                VStack(alignment: .leading, spacing:5){
                                    Text(transaction.name)
                                        .font(Font.custom("DIN Alternate Bold", size: 14))
                                        .bold()
                                    HStack(){
                                        Text("Bank of America")
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
                                    Text("$\(transaction.amount * (-1), specifier: "%.2f")")
                                        .font(Font.custom("DIN Alternate Bold", size: 14))
                                        .foregroundColor(Color(.systemGreen))
                                        .bold()
                                }
                                HStack(){
                                    Spacer()
                                    transaction.pending ?
                                        Text("\(transaction.date)")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                        :
                                        Text("Pending")
                                        .font(Font.custom("DIN Alternate Bold", size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        Divider()
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                }
                .frame(width: 375, height: 230)
            }
        }
    }
}

struct MenuView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var showMenu: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(){
                VStack(alignment: .center){
                    Image("b")
                        .resizable()
                        .frame(width:150, height:150)
                        .padding(.top, 70)
                    VStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color(.systemGray3))
                            .frame(height: 1)
                            .padding(.top, 30)
                        Button(action: { viewRouter.currentPage = .page8; } ){
                            HStack {
                                Image(systemName: "person")
                                    .foregroundColor(darkPurple)
                                    .imageScale(.medium)
                                    .padding(.trailing, 10)
                                Text("Profile")
                                    .foregroundColor(Color(.darkGray))
                                    .font(.body)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.darkGray))
                                    .imageScale(.small)
                            }
                        }
                        .padding(.top, 50)
                        Button(action: { viewRouter.currentPage = .page7; } ) {
                            HStack {
                                Image(systemName: "bell")
                                    .foregroundColor(darkPurple)
                                    .imageScale(.medium)
                                    .padding(.trailing, 10)
                                Text("Notifications")
                                    .foregroundColor(Color(.darkGray))
                                    .font(.body)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.darkGray))
                                    .imageScale(.small)
                            }
                        }
                        .padding(.top, 50)
                        Button(action: { viewRouter.currentPage = .page9;} ) {
                            HStack {
                                Image(systemName: "gearshape")
                                    .foregroundColor(darkPurple)
                                    .imageScale(.medium)
                                    .padding(.trailing, 10)
                                Text("Settings")
                                    .foregroundColor(Color(.darkGray))
                                    .font(.body)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.darkGray))
                                    .imageScale(.small)
                            }
                        }
                        .padding(.top, 50)
                        Button(action: { viewRouter.currentPage = .page10;} ) {
                            HStack {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(darkPurple)
                                    .imageScale(.medium)
                                    .padding(.trailing, 10)
                                Text("Help")
                                    .foregroundColor(Color(.darkGray))
                                    .font(.body)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.darkGray))
                                    .imageScale(.small)
                            }
                        }
                        .padding(.top, 50)
                        Rectangle()
                            .fill(Color(.systemGray3))
                            .frame(height: 1)
                            .padding(.top,50)
                        Button(action: {
                                do{
                                    try Auth.auth().signOut();
                                    UserDefaults.standard.set(false, forKey: "logged_in")
                                    viewRouter.currentPage = .page2;
                                }
                                catch{
                                    debugPrint(error.localizedDescription)
                                }}) {
                            HStack {
                                Image(systemName: "arrow.down.left.circle")
                                    .foregroundColor(darkPurple)
                                    .imageScale(.medium)
                                    .padding(.trailing, 10)
                                Text("Log Out")
                                    .foregroundColor(Color(.darkGray))
                                    .font(.body)
                                Spacer()
                            }
                        }
                        .padding(.top, 50)
                        Spacer()
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                }
                .frame(width: UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height)
                .background(Rectangle()
                                .fill(Color(.systemGray5))
                                .shadow(radius: 5))
            }
        }
    }
}

struct Card: View {
    @State var width: CGFloat = 0
    @State var height: CGFloat = 0
    
    var body : some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color.white)
            .frame(width: width, height: height)
            .shadow(color: Color.gray.opacity(0.25), radius: 5, x: 0, y: 0)
    }
    
}

struct Divider: View {
    var body : some View {
        Rectangle()
            .fill(Color(.systemGray6))
            .frame(height: 1)
    }
}

struct ProgressCircle: View {
    @State var percentage: CGFloat
    @State var color: Color
    @State var iconName: String
    
    var body : some View {
        ZStack(){
            Circle()
                .stroke(Color(.systemGray6), lineWidth: 3)
                .frame(width: 40, height:40)
            Circle()
                .trim(from: 0, to: percentage)
                .stroke(color, lineWidth: 3)
                .frame(width: 40, height:40)
                .rotationEffect(.degrees(-90))
            Image(systemName: iconName)
                .foregroundColor(Color(.systemGray3))
        }
    }
    
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView()
        }
    }
}
