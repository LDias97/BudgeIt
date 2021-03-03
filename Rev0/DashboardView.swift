import SwiftUI

let darkPurple = Color(red: 96/255, green: 96/255, blue: 235/255)
let lightPurple = Color(red: 177/255, green: 127/255, blue: 248/255)
let red = Color(red: 220/255, green: 104/255, blue: 101/255)
let green = Color(red: 87/255, green: 210/255, blue: 150/255)

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
        ZStack(alignment:.top){
            Rectangle()
                .fill(Color(red: 240/255, green: 240/255, blue: 240/255))
                .ignoresSafeArea()
            VStack(spacing: 30){
                ZStack(alignment:.top){
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [darkPurple, lightPurple]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: 430, height: 200)
                        .ignoresSafeArea()
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
                Button(action: { viewRouter.currentPage = .page3; }){
                    BudgetCardView()
                        .foregroundColor(.black)
                }
                .padding(.bottom, 15)
                Button(action: { viewRouter.currentPage = .page4; }){
                    SpendingCardView()
                        .foregroundColor(.black)
                }
            }
        }
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
    
    var body : some View {
        ZStack(alignment: .top){
            Rectangle()
                .fill(Color(.white))
                .frame(width: 375, height: 150 )
                .cornerRadius(30.0)
            HStack(){
                Text("Spending")
                    .font(.headline)
                    .bold()
                Spacer()
            }
            .padding(.leading, 50)
            .padding(.top, 20)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
