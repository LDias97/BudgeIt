import SwiftUI

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
