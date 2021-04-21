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
                    BudgetsGroup(isEnabled1: $isEnabled1, isEnabled2: $isEnabled2, isEnabled3: $isEnabled3)
                    Separator()
                    SpendingGroup(isEnabled1: $isEnabled4, isEnabled2: $isEnabled5, isEnabled3: $isEnabled6)
                    Separator()
                    IncomeGroup(isEnabled1: $isEnabled7, isEnabled2: $isEnabled8, isEnabled3: $isEnabled9)
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
    @Binding var isEnabled1: Bool
    @Binding var isEnabled2: Bool
    @Binding var isEnabled3: Bool
    @State private var showingAlert = false
    
//    func present(_ viewControllerToPresent: UIViewController), animated flag: Bool, completion: (() -> Void)? = nil)
    
    var body : some View {
        HStack{
            Text("Budgets")
                .font(.title3)
                .bold()
            Spacer()
        }
        Toggle("50%", isOn: $isEnabled1)
        Toggle("90%", isOn: $isEnabled2)
        Toggle("100%", isOn: $isEnabled3)
    }
}

struct SpendingGroup: View {
    @Binding var isEnabled1: Bool
    @Binding var isEnabled2: Bool
    @Binding var isEnabled3: Bool
    var body : some View {
        HStack{
            Text("Spending")
                .font(.title3)
                .bold()
            Spacer()
        }
        Toggle("Transactions over $100", isOn: $isEnabled1)
        Toggle("Transactions over $500", isOn: $isEnabled2)
        Toggle("Transactions over $1000", isOn: $isEnabled3)
    }
}
struct IncomeGroup: View {
    @Binding var isEnabled1: Bool
    @Binding var isEnabled2: Bool
    @Binding var isEnabled3: Bool
    
    var body : some View {
        HStack{
            Text("Income")
                .font(.title3)
                .bold()
            Spacer()
        }
        Toggle("Deposits over $100", isOn: $isEnabled1)
        Toggle("Deposits over $500", isOn: $isEnabled2)
        Toggle("Deposits over $1000", isOn: $isEnabled3)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

