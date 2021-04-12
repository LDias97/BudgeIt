import SwiftUI
import UserNotifications

struct BudgetDetailView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var auto: String = ""
    @State var food: String = ""
    @State var entertainment: String = ""
    @State var bills: String = ""
    @State var selectedMonth: Int = 0
    
    var body: some View {
        ScrollView {
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
                        Text("BudgeIt")
                            .font(.title3)
                            .bold()
                            .padding(.top)
                            .foregroundColor(Color(.systemGreen))
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
                    .padding(.top, 40)
                    BarChartView(selectedMonth: $selectedMonth)
                    Spacer()
                    BudgetOptionsView()
                        .padding(.top, 30)
                }
                .padding(.top, 20)
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

struct BarChartView: View {
    @Binding var selectedMonth: Int
    
    let months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    var body : some View {
        ScrollView(.horizontal){
            ScrollViewReader { value in
                ZStack{
                    HStack {
                        // ForEach loop for green bar
                        ForEach(0..<12) { income in
                            VStack{
                                HStack{
                                    VStack(){
                                        Spacer()
                                    Rectangle()
                                        .fill(Color.green)
                                        .frame(width: 40, height: 75)
                                        .ignoresSafeArea()
                                    }
                                    // Inner ForEach loop for blue bar
                                    ForEach(0..<1) { spending in
                                        HStack{
                                            Rectangle()
                                                .fill(Color.blue)
                                                .frame(width: 40, height: 100)
                                                .ignoresSafeArea()
                                        }
                                    }
                                }
                                .padding(20) // Distance between each month
                                .padding(.top, 50)
                                Button(months[income]){ // Month labels (X-Axis)
                                    value.scrollTo(income)
                                }
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        MonthlyInfoView(selectedMonth: $selectedMonth)
    }
}

// Bottom Monthly info scroll
struct MonthlyInfoView: View {
    
    let months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var incomeValue: Double = 0.0
    var spendingValue: Double = 0.0
    var difference: Double = 0.0 // income - spending, cast to string
    var id: Int = 0
    
    @Binding var selectedMonth: Int

    
    var body : some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(0..<12) { month in
                        VStack {
                            HStack{
                                VStack {
                                    Text(months[month] + " 2021")
                                        .foregroundColor(.black)
                                        .padding(.leading, 30)
                                        .font(.largeTitle)
                                    
                                    if difference < 0 {
                                        Text("Shortfall:")
                                            .foregroundColor(.black)
                                            .padding(.bottom, 5)
                                    } else {
                                        Text("Surplus:")
                                            .foregroundColor(.black)
                                            .padding(.bottom, 5)
                                    }
                                }
                                Spacer()
                                VStack{
                                    Text("Income")
                                        .padding(.trailing, 30)
                                    Text("$1200.00")
                                        .padding(.trailing, 30)
                                        .foregroundColor(Color(.systemGreen))
                                }
                            }
                            HStack{
                                Text("$700.00") // Change to Text(difference)
                                    .padding(.leading, 50)
                                    .font(.title3)
                                    .foregroundColor(Color(.systemGreen)) // Should be red if shortfall
                                Spacer()
                                VStack{
                                    Text("Spending")
                                        .padding(.trailing, 30)
                                    Text("$500.00")
                                        .padding(.trailing, 30)
                                        .foregroundColor(Color(.red))
                                }
                            }
                        }
                        .padding(.top, 10)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                }
            }
        }
    }


struct BudgetOptionsView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var auto: String = ""
    @State var food: String = ""
    @State var entertainment: String = ""
    @State var bills: String = ""
    
    // Notification Variables
    @State var autoReachedAlert: Bool = false
    @State var foodReachedAlert: Bool = false
    @State var enterReachedAlert: Bool = false
    @State var billsReachedAlert: Bool = false
    
    var body : some View {
        ZStack(alignment: .top){
            Rectangle()
                .fill(Color(.white))
                .frame(width: 375, height: 210)
                .cornerRadius(30.0)
            VStack(spacing: 20){
                // Set Monthly Budget Limits
                Text("Monthly Budgets")
                    .font(.title3)
                    .foregroundColor(.black)
                    .bold()
                    .padding(.top, 5)
                HStack{
                    Text("Auto:")
                        .font(.headline)
                        .foregroundColor(Color(.blue))
                        .padding(.leading, 40)
                    Spacer()
                    TextField("$0.00", text: $auto)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 40)
                        .foregroundColor(.black)
                }
                HStack{
                    Text("Food & Restaurants:")
                        .font(.headline)
                        .foregroundColor(Color(.systemTeal))
                        .padding(.leading, 40)
                    Spacer()
                    TextField("$0.00", text: $food)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 40)
                        .foregroundColor(.black)
                }
                HStack{
                    Text("Entertainment:")
                        .font(.headline)
                        .foregroundColor(Color(.red))
                        .padding(.leading, 40)
                    Spacer()
                    TextField("$0.00", text: $entertainment)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 40)
                        .foregroundColor(.black)
                }
                HStack{
                    Text("Bills:")
                        .font(.headline)
                        .foregroundColor(Color(.orange))
                        .padding(.leading, 40)
                    Spacer()
                    TextField("$0.00", text: $bills)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 40)
                        .foregroundColor(.black)
                }
            }
        }
        
        ZStack {
            // Budget Notifications
            Rectangle()
                .fill(Color(.white))
                .frame(width: 375, height: 210)
                .cornerRadius(30.0)
            VStack{
                // Set Monthly Budget Limits
                Text("Get Notified")
                    .font(.title3)
                    .foregroundColor(.black)
                    .bold()
                    .padding(.top, 5)
                Toggle("Auto", isOn: $autoReachedAlert)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .foregroundColor(Color(.blue))
                Toggle("Food & Restaurtants", isOn: $foodReachedAlert)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .foregroundColor(Color(.systemTeal))
                Toggle("Entertainment", isOn: $enterReachedAlert)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .foregroundColor(Color(.red))
                Toggle("Bills", isOn: $billsReachedAlert)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .foregroundColor(Color(.orange))
            }
        }
        .padding(.bottom, 40)
    }
}

struct BudgetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetDetailView()
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




//if exceedBudget {
//    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) {
//        success, error in
//        if success {
//            print("All set!")
//        } else if let error = error {
//            print(error.localizedDescription)
//        }
//    }
//}

// Budget Notification Settings
//                    let budgetReachedToggle = Binding<Bool> (
//                        get: {self.budgetReachedAlert},
//                        set: {newValue in self.budgetReachedAlert = newValue}
//                    )
//Toggle("Budget Reached", isOn: $budgetReachedAlert)
//    .padding(20)
//if budgetReachedAlert {
//    Text("This is a test!")
//}
//
//Toggle("BudgeIt Tips", isOn: $budgetTipsAlert)
//    .padding(20)
