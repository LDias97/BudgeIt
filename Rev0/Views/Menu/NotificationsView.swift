import SwiftUI
import UserNotifications

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
    
    @State var messages: [String] = []
    
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
                    Notifications(items: messages)
                    Separator()
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

//struct Items {
//    var message: String
//}
//
//class NotifyItems: ObservableObject {
//    @Published var items = [Items]()
//
//}

struct Notifications: View {
    @State var items = ["Auto Budget Exceeded!", "Recreational Budget Exceeded!","Food & Restaurant Budget Exceeded!", "Credit Card Budget Exceeded!"]

    //@ObservedObject var values = NotifyItems()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Recent Notifications")
            .padding(.leading, 5)
            .padding(.trailing, 5)
            .navigationBarItems(trailing: Button(action: {
                self.items.removeAll()                
            })  {
                    Text("Clear")
                }
            )
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        self.items.remove(atOffsets: offsets)
    }
}

struct BudgetsGroup: View {
    @Binding var isEnabled1: Bool
    @Binding var isEnabled2: Bool
    @Binding var isEnabled3: Bool
    @State private var showingAlert = false
    
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

//Button("Send Notification") {
//    let content = UNMutableNotificationContent()
//    content.title = "Feed the cat"
//    content.subtitle = "It looks hungery"
//    content.sound = UNNotificationSound.default
//    
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//    
//    UNUserNotificationCenter.current().add(request)
//}
