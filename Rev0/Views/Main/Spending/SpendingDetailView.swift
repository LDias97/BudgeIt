import SwiftUI

struct SpendingDetailView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userData: UserData
    @State var num = 0
    
    var body: some View {
        ZStack(){
            Rectangle()
                .fill(grey)
                .ignoresSafeArea()
            VStack() {
                HStack(){
                    BackButton(page: .page3)
                        .padding(.leading, 15)
                    Spacer()
                    Text("Spending")
                        .font(Font.custom("DIN Alternate Bold", size: 24))
                        .padding(.top)
                    Spacer()
                    EllipsisButton()
                        .padding(.trailing, 15)
                }
                SpendingPieView(num: $num, svm: SpendingViewModel(userData: userData))
                    .padding(.top, 50)
                    .animation(Animation.interactiveSpring())
                Spacer()
                SpendingTableView(num: $num, svm: SpendingViewModel(userData: userData))
                    .padding(.top, 50)
            }
            .padding(.top, 50)
        }
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct SpendingPieView : View {
    @Binding var num: Int
    @ObservedObject var svm: SpendingViewModel
    
    var body : some View {
        ZStack(){
            ForEach(svm.slices) { slice in
                Circle()
                    .trim(from: slice.start, to: slice.end)
                    .stroke(slice.color, lineWidth: (svm.categories[num] == slice.name) ? 50 : 30)
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(-90))
                if(svm.categories[num] == slice.name){
                    Text(slice.percentage >= 0.01 ? (String(format: "%.0f", slice.percentage * 100) + "%") : "<1%")
                    .font(Font.custom("DIN Alternate Bold", size: 50))
                    .foregroundColor(.black)
                    .padding(.leading)
                }
            }
        }.onAppear(perform: { svm.getSlices() })
    }
}

struct SpendingTableView : View {
    @Binding var num: Int
    @EnvironmentObject var userData: UserData
    @ObservedObject var svm: SpendingViewModel
    
    var body : some View {
        ZStack(){
            Rectangle()
                .fill(Color.white)
                .frame(width: 400, height: 500)
            VStack(){
                SelectorBar(svm: svm, num: $num)
                Divider()
                ScrollView{
                    VStack() {
                        ForEach(userData.spending) { transaction in
                            if(transaction.category!.key == svm.categories[num]){
                                VStack(spacing: 10){
                                    SpendingCell(name: transaction.name, amount: transaction.amount, pending: transaction.pending, date: transaction.date, color: transaction.category!.color)
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
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 20)
        }
    }
}

struct SelectorBar: View {
    @ObservedObject var svm: SpendingViewModel
    @Binding var num: Int
    
    var body : some View {
        HStack(){
            Button(action: {
                num = (num == 0 ? num + svm.categories.count - 1 : num - 1)
            } ) {
                Image(systemName: "chevron.backward")
                    .imageScale(.large)
                    .foregroundColor(Color(.black))
            }
            .padding(.leading, 15)
            Spacer()
            Text(svm.categories[num])
                .font(Font.custom("DIN Alternate Bold", size: 22))
            Spacer()
            Button(action: {
                num = ((num == svm.categories.count - 1) ? 0 : num + 1)
            } ) {
                Image(systemName: "chevron.forward")
                    .imageScale(.large)
                    .foregroundColor(Color(.black))
            }
            .padding(.trailing, 15)
        }
    }
}

// FIX: Hardcoded institution text
struct SpendingCell: View {
    let name: String
    let amount: Double
    let pending: Bool
    let date: String
    let color: Color
    
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
                    Text("-$\(amount, specifier: "%.2f")")
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
