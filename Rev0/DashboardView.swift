import SwiftUI

let darkPurple = Color(red: 96/255, green: 96/255, blue: 235/255)
let lightPurple = Color(red: 177/255, green: 127/255, blue: 248/255)
let red = Color(red: 220/255, green: 104/255, blue: 101/255)
let green = Color(red: 87/255, green: 210/255, blue: 150/255)

// Move over DetailView and PieView structs into this class rather than "SpendingDetailView" since other views such as Income and Budget may use it as well
// Have this page work as parent class?

struct DashboardView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var earned: String = ""
    @State var spent: String = ""
    @State var currentNetWorth: String = ""
    @State var previousNetWorth: String = ""
    @State var auto: String = ""
    @State var food: String = ""
    @State var entertainment: String = ""
    @State var bills: String = ""
    
    var body: some View {
        ScrollView{
            ZStack(alignment:.top){
                Rectangle()
                    .fill(Color(red: 240/255, green: 240/255, blue: 240/255))
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [darkPurple, lightPurple]), startPoint: .leading, endPoint: .trailing))
                    .padding(.bottom, 768)
                    .frame(width: 414, height: 1012)
                VStack(spacing: 30){
                    ZStack(alignment:.top){
                        VStack(){
                            HStack(){
                                Button(action: { print(" hamburger menu clicked" )} ) {
                                    Image(systemName: "line.horizontal.3")
                                        .imageScale(.large)
                                        .foregroundColor(Color(.white))
                                }
                                .padding(.leading, 30)
                                Spacer()
                            }
                            HStack(){
                                Text("Dashboard")
                                    .font(.title)
                                    .foregroundColor(Color(.white))
                                Spacer()
                            }
                            .padding(.leading, 30)
                            .padding(.top, 20)
                        }
                        .padding(.top, 20)
                        NetWorthCardView()
                    }
                    .padding(.top, 44)
                    // Open BudgeItDetailViews
                    Button(action: { viewRouter.currentPage = .page3; }){
                        BudgetCardView()
                            .foregroundColor(.black)
                    }
                    // Open SpendingDetailView
                    Button(action: { viewRouter.currentPage = .page4; }){
                        SpendingCardView()
                            .foregroundColor(.black)
                    }
                    // Open IncomeDetailView
                    Button(action: { viewRouter.currentPage = .page6; }){
                        IncomeCardView()
                            .foregroundColor(.black)
                    }
                    .padding(.bottom, 15)
                }
            }
        }
        .background(VStack(){
            Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [darkPurple, lightPurple]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: 414, height: 406)
                        .ignoresSafeArea()
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Rectangle()
                .fill(Color(red: 240/255, green: 240/255, blue: 240/255))
        })
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct NetWorthCardView: View {
    
    var body: some View {
        ZStack(){
            Rectangle()
                .fill(Color(.white))
                .frame(width: 375, height: 150 )
                .cornerRadius(30.0)
            HStack(){
                VStack(spacing: 20){
                    HStack(){
                        Text("Net Worth")
                            .foregroundColor(.black)
                            .font(.headline)
                            .bold()
                        Spacer()
                    }
                    HStack(){
                        Text("$5,047.00")
                            .foregroundColor(green)
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    HStack(){
                        Text("-$400 this month")
                            .foregroundColor(.red)
                            .font(.caption2)
                        Spacer()
                    }
                }
                .padding(.leading, 50)
                VStack(spacing: 20){
                    HStack(){
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(green)
                        VStack(spacing: 5){
                            Text("Earned")
                                .foregroundColor(Color(.systemGray))
                            Text("$1,430")
                        }
                    }
                    HStack(){
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(red)
                        VStack(spacing: 5){
                            Text("Spent")
                                .foregroundColor(Color(.systemGray))
                            Text("$1,830")
                        }
                    }
                }
                .padding(.trailing, 75)
            }
        }
        .padding(.top, 120)
    }
}

struct BudgetCardView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        ZStack(alignment: .top){
            Rectangle()
                .fill(Color(.white))
                .frame(width: 375, height: 350 )
                .cornerRadius(30.0)
            VStack(spacing: 10){
                HStack(){
                    Text("Budgets")
                        .font(.headline)
                    Spacer()
                    
                    // BudgetDetailView Button Action
                    Button(action: {
                            viewRouter.currentPage = .page5
                            print("BudgetDetailView clicked" )} ) {
                        Image(systemName: "chevron.forward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    .padding(.trailing, 50)
                }
                .padding(.leading, 50)
                .padding(.top, 20)
                
                HStack(){
                    ZStack(){
                        Circle()
                            .stroke(Color(.systemGray6), lineWidth: 2)
                            .frame(width: 40, height:40)
                        Circle()
                            .trim(from: 0.0, to: 0.9)
                            .stroke(Color(.blue), lineWidth: 2)
                            .frame(width: 40, height:40)
                            .rotationEffect(.degrees(-90))
                        Image(systemName: "car.fill")
                            .foregroundColor(Color(.systemGray3))                            }
                    VStack(spacing: 5){
                        HStack(){
                            Text("Auto & Transport")
                                .font(.caption)
                                .bold()
                            Spacer()
                            
                        }
                        HStack(){
                            Text("$700 left")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()}
                        
                    }
                    Spacer()
                    VStack(spacing: 5){
                        HStack(){
                            Spacer()
                            Text("$1,200")
                                .font(.caption)
                                .foregroundColor(Color(.blue))
                                .bold()
                        }
                        HStack(){
                            Spacer()
                            Text("$500 of 1,200")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 20)
                
                HStack(){
                    ZStack(){
                        Circle()
                            .stroke(Color(.systemGray6), lineWidth: 2)
                            .frame(width: 40, height:40)
                        Circle()
                            .trim(from: 0.0, to: 0.7)
                            .stroke(Color(.systemTeal), lineWidth: 2)
                            .frame(width: 40, height:40)
                            .rotationEffect(.degrees(-90))
                        Image(systemName: "cart.fill")
                            .foregroundColor(Color(.systemGray3))                            }
                    VStack(spacing: 5){
                        HStack(){
                            Text("Food & Restaurants")
                                .font(.caption)
                                .bold()
                            Spacer()
                            
                        }
                        HStack(){
                            Text("$700 left")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()}
                    }
                    Spacer()
                    VStack(spacing: 5){
                        HStack(){
                            Spacer()
                            Text("$1,200")
                                .font(.caption)
                                .foregroundColor(Color(.blue))
                                .bold()
                        }
                        HStack(){
                            Spacer()
                            Text("$500 of 1,200")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 20)
                
                HStack(){
                    ZStack(){
                        Circle()
                            .stroke(Color(.systemGray6), lineWidth: 2)
                            .frame(width: 40, height:40)
                        Circle()
                            .trim(from: 0, to: 0.75)
                            .stroke(Color(.systemPink), lineWidth: 2)
                            .frame(width: 40, height:40)
                            .rotationEffect(.degrees(-90))
                        Image(systemName: "gamecontroller.fill")
                            .foregroundColor(Color(.systemGray3))
                    }
                    VStack(spacing: 5){
                        HStack(){
                            Text("Entertainment")
                                .font(.caption)
                                .bold()
                            Spacer()
                            
                        }
                        HStack(){
                            Text("$700 left")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()}
                        
                    }
                    Spacer()
                    VStack(spacing: 5){
                        HStack(){
                            Spacer()
                            Text("$1,200")
                                .font(.caption)
                                .foregroundColor(Color(.blue))
                                .bold()
                        }
                        HStack(){
                            Spacer()
                            Text("$500 of 1,200")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 20)
                
                HStack(){
                    ZStack(){
                        Circle()
                            .stroke(Color(.systemGray6), lineWidth: 2)
                            .frame(width: 40, height:40)
                        Circle()
                            .trim(from: 0.0, to: 0.6)
                            .stroke(Color(.systemOrange), lineWidth: 2)
                            .frame(width: 40, height:40)
                            .rotationEffect(.degrees(-90))
                        Image(systemName: "house.fill")
                            .foregroundColor(Color(.systemGray3))
                    }
                    
                    VStack(spacing: 5){
                        HStack(){
                            Text("Bills")
                                .font(.caption)
                                .bold()
                            Spacer()
                            
                        }
                        HStack(){
                            Text("$700 left")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()}
                        
                    }
                    Spacer()
                    VStack(spacing: 5){
                        HStack(){
                            Spacer()
                            Text("$1,200")
                                .font(.caption)
                                .foregroundColor(Color(.blue))
                                .bold()
                        }
                        HStack(){
                            Spacer()
                            Text("$500 of 1,200")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 20)
            }
        }
    }
}


struct SpendingCardView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack(alignment: .top){
            Rectangle()
                .fill(Color(.white))
                .frame(width: 375, height: 350 )
                .cornerRadius(30.0)
            VStack(spacing: 10){
                HStack(){
                    Text("Spending")
                        .font(.headline)
                    
                    Spacer()
                    
                    // SpendingDetailView Button Action
                    Button(action:{
                            viewRouter.currentPage = .page4;
                            print("SpendingDetailView clicked")} )
                    {
                        Image(systemName: "chevron.forward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    .padding(.trailing, 50)
                }
                .padding(.leading, 50)
                .padding(.top, 20)
                
                // Transaction 1 - "Auto and Transport Example"
                HStack(){
                    VStack(spacing: 5){
                        HStack(){
                            Text("Shell Gas")
                                .font(.caption)
                                .bold()
                                .foregroundColor(Color(.blue))
                            Spacer()
                            
                        }
                        HStack(){
                            Text("Bank of America")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()}
                        
                    }
                    Spacer()
                    VStack(spacing: 5){
                        HStack(){
                            Spacer()
                            Text("-$45.58")
                                .font(.caption)
                                .foregroundColor(Color(.red))
                                .bold()
                        }
                        HStack(){
                            Spacer()
                            Text("Processing 3/2/21")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 20)
                
                // Transaction 2 - "Food Example"
                HStack(){
                    VStack(spacing: 5){
                        HStack(){
                            Text("Chik-Fil-A")
                                .font(.caption)
                                .bold()
                                .foregroundColor(Color(.systemTeal))
                            Spacer()
                            
                        }
                        HStack(){
                            Text("Bank of America")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()}
                    }
                    Spacer()
                    VStack(spacing: 5){
                        HStack(){
                            Spacer()
                            Text("-$23.75")
                                .font(.caption)
                                .foregroundColor(Color(.red))
                                .bold()
                        }
                        HStack(){
                            Spacer()
                            Text("Processed on 3/3/21")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 20)
                
                // Transaction 3 - "Entertainment Example"
                HStack(){
                    VStack(spacing: 5){
                        HStack(){
                            Text("PS Plus")
                                .font(.caption)
                                .bold()
                                .foregroundColor(Color(.systemPink))
                            Spacer()
                            
                        }
                        HStack(){
                            Text("Bank of America")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()}
                        
                    }
                    Spacer()
                    VStack(spacing: 5){
                        HStack(){
                            Spacer()
                            Text("-$59.99")
                                .font(.caption)
                                .foregroundColor(Color(.red))
                                .bold()
                        }
                        HStack(){
                            Spacer()
                            Text("Processed on 2/27/21")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 20)
                
                // Transaction 4 - "Bills Example"
                HStack(){
                    VStack(spacing: 5){
                        HStack(){
                            Text("National Grid")
                                .font(.caption)
                                .bold()
                                .foregroundColor(Color(.systemOrange))
                            Spacer()
                            
                        }
                        HStack(){
                            Text("Rockland Trust")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()}
                        
                    }
                    Spacer()
                    VStack(spacing: 5){
                        HStack(){
                            Spacer()
                            Text("-$1,200")
                                .font(.caption)
                                .foregroundColor(Color(.red))
                                .bold()
                        }
                        HStack(){
                            Spacer()
                            Text("Processing 3/3/21")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 20)
            }
        }
    }
}

struct IncomeCardView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack(alignment: .top){
            Rectangle()
                .fill(Color(.white))
                .frame(width: 375, height: 350 )
                .cornerRadius(30.0)
            VStack(spacing: 10){
                HStack(){
                    Text("Income")
                        .font(.headline)
                    
                    Spacer()
                    
                    // IncomeDetailView Button Action
                    Button(action:{
                            viewRouter.currentPage = .page4;
                            print("IncomeDetailView clicked")} )
                    {
                        Image(systemName: "chevron.forward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    .padding(.trailing, 50)
                }
                .padding(.leading, 50)
                .padding(.top, 20)
                
                // Deposit 1 - "Work"
                HStack(){
                    VStack(spacing: 5){
                        HStack(){
                            Text("Work")
                                .font(.caption)
                                .bold()
                            Spacer()
                            
                        }
                        HStack(){
                            Text("Bank of America")
                                .font(.caption2)
                            Spacer()}
                        
                    }
                    Spacer()
                    VStack(spacing: 5){
                        HStack(){
                            Spacer()
                            Text("+$1000.50")
                                .font(.caption)
                                .foregroundColor(Color(.green))
                                .bold()
                        }
                        HStack(){
                            Spacer()
                            Text("Processing 3/2/21")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 20)
                
                // Deposit 2 - "ATM"
                HStack(){
                    VStack(spacing: 5){
                        HStack(){
                            Text("ATM Deposit")
                                .font(.caption)
                                .bold()
                            Spacer()
                            
                        }
                        HStack(){
                            Text("Bank of America")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()}
                    }
                    Spacer()
                    VStack(spacing: 5){
                        HStack(){
                            Spacer()
                            Text("+$200.00")
                                .font(.caption)
                                .foregroundColor(Color(.green))
                                .bold()
                        }
                        HStack(){
                            Spacer()
                            Text("Processed on 3/3/21")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 20)
                
                // Depsoit 3 - "Work"
                HStack(){
                    VStack(spacing: 5){
                        HStack(){
                            Text("Work")
                                .font(.caption)
                                .bold()
                            Spacer()
                            
                        }
                        HStack(){
                            Text("Bank of America")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()}
                        
                    }
                    Spacer()
                    VStack(spacing: 5){
                        HStack(){
                            Spacer()
                            Text("+$1050.00")
                                .font(.caption)
                                .foregroundColor(Color(.green))
                                .bold()
                        }
                        HStack(){
                            Spacer()
                            Text("Processed on 2/27/21")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 20)
                
                // Deposit 4 - "Transfer"
                HStack(){
                    VStack(spacing: 5){
                        HStack(){
                            Text("Transfer from Venmo")
                                .font(.caption)
                                .bold()
                            Spacer()
                            
                        }
                        HStack(){
                            Text("Venmo")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()}
                        
                    }
                    Spacer()
                    VStack(spacing: 5){
                        HStack(){
                            Spacer()
                            Text("+$8.75")
                                .font(.caption)
                                .foregroundColor(Color(.green))
                                .bold()
                        }
                        HStack(){
                            Spacer()
                            Text("Processing 3/3/21")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 20)
            }
        }
    }
}

struct MenuView: View {
    var body: some View {
        ZStack(){
        VStack(alignment: .leading) {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [darkPurple, lightPurple]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 207, height: 1012)
                .padding(.trailing, 207)
        }
        VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.white)
                            .imageScale(.large)
                        Text("Profile")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                        .padding(.top, 100)
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.white)
                            .imageScale(.large)
                        Text("Messages")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                        .padding(.top, 30)
                    HStack {
                        Image(systemName: "gear")
                            .foregroundColor(.white)
                            .imageScale(.large)
                        Text("Settings")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                        .padding(.top, 30)
                Spacer()
                }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [darkPurple, lightPurple]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: 207, height: 1012)
                        .padding(.trailing, 207))
        .edgesIgnoringSafeArea(.all)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView()
            MenuView()
        }
    }
}

