import SwiftUI

struct NetWorthCardView: View {
    @EnvironmentObject var userData: UserData
    @ObservedObject var viewModel: NetWorthViewModel
    @State var degrees: Double = 180
    
    var body: some View {
        ZStack{
            if !userData.hasLoaded || viewModel.currentBalance == 0{
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

struct GreetingCardView: View {
    @State var timeOfDay: String = "evening"
    
    var body: some View {
        ZStack(){
            Card(width: 375, height: 150)
//            Text("Good \(timeOfDay) \(UserDefaults.standard.value(forKey: "name") as! String)!")
//                .font(.custom("DIN Alternate Bold", size: 28))
//                .foregroundColor(.green)
        }
    }
}
