import SwiftUI

struct NotificationsView: View {
    
    @State var isEnabled1: Bool = false
    @State var isEnabled2: Bool = false
    @State var isEnabled3: Bool = false
    @State var isEnabled4: Bool = false
    @State var isEnabled5: Bool = false
    @State var isEnabled6: Bool = false
    @State var isEnabled7: Bool = false
    @State var isEnabled8: Bool = false
    @State var isEnabled9: Bool = false
    @State var isEnabled10: Bool = false


    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        ZStack(alignment:.top){
            Rectangle()
                .fill(Color(.systemGray6))
            VStack(){
                HStack{
                    Button(action: { viewRouter.currentPage = .page3; } ) {
                        Image(systemName: "chevron.backward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    Spacer()
                    Text("Notifications")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                .padding(.top, 70)
                Spacer()
                VStack(){
                    BudgetsGroup(isEnabled: $isEnabled1)
                    Separator()
                    SpendingGroup(isEnabled: $isEnabled2)
                    Separator()
                    IncomeGroup(isEnabled: $isEnabled3)
                }
                Spacer()
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct Separator: View {
    var body : some View {
        Rectangle()
            .frame(height: 0.5)
            .padding(.top)
            .padding(.bottom)
    }
}

struct BudgetsGroup: View {
    @Binding var isEnabled: Bool
    var body : some View {
        HStack{
            Text("Budgets")
                .font(.title3)
                .bold()
            Spacer()
        }
        Toggle("50%", isOn: $isEnabled)
        Toggle("90%", isOn: $isEnabled)
        Toggle("100%", isOn: $isEnabled)
    }
}
struct SpendingGroup: View {
    @Binding var isEnabled: Bool
    var body : some View {
        HStack{
            Text("Spending")
                .font(.title3)
                .bold()
            Spacer()
        }
        Toggle("Transactions over $100", isOn: $isEnabled)
        Toggle("Transactions over $500", isOn: $isEnabled)
        Toggle("Transactions over $1000", isOn: $isEnabled)
    }
}
struct IncomeGroup: View {
    @Binding var isEnabled: Bool
    var body : some View {
        HStack{
            Text("Income")
                .font(.title3)
                .bold()
            Spacer()
        }
        Toggle("Deposits over $100", isOn: $isEnabled)
        Toggle("Deposits over $500", isOn: $isEnabled)
        Toggle("Deposits over $1000", isOn: $isEnabled)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

