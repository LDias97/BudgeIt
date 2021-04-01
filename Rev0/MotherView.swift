import SwiftUI
<<<<<<< HEAD
import LinkKit
import UIKit
import FirebaseFunctions
=======
>>>>>>> d0023eafe1975bcfe9abcd80aa86df31be68fe48

enum Page {
    case page1 // SignUp
    case page2 // LogIn
    case page3 // Dashboard
    case page4 // Spending
    case page5 // BudgeIt
    case page6 // Income
    case page7 // Notifications
    case page8 // Profile
    case page9 // Settings
    case page10 // Help
    case page11 // Bank Accounts
}

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
<<<<<<< HEAD
    @State private var showLink = false
    @State var isPresented = false
=======
>>>>>>> d0023eafe1975bcfe9abcd80aa86df31be68fe48
    
    var body: some View {
        switch viewRouter.currentPage{
        case .page1:
            SignUpView()
        case .page2:
            LogInView()
        case .page3:
            DashboardView()
        case .page4:
            SpendingDetailView()
        case .page5:
            BudgetDetailView()
        case .page6:
            IncomeDetailView()
        case .page7:
            NotificationsView()
        case .page8:
            ProfileView()
        case .page9:
            SettingsView()
        case .page10:
            HelpView()
        case .page11:
<<<<<<< HEAD
            Button("Open Plaid") { self.isPresented = true}
                .sheet(isPresented: $isPresented) {
                    LinkView(isPresented: $isPresented)}
=======
            LinkView()
>>>>>>> d0023eafe1975bcfe9abcd80aa86df31be68fe48
        }
    }
}

<<<<<<< HEAD
struct LinkView: View {
    @Binding var isPresented: Bool
    @ObservedObject var token = Token()
    
    var body: some View {
        Group{
            if token.hasLoaded {
                LinkController(configuration: .linkToken(token.vc.createLinkTokenConfiguration()))
            }
            else {
                Text("Loading Plaid")
            }
        }.onAppear(){
            self.token.setToken()
        }

    }
}
=======

>>>>>>> d0023eafe1975bcfe9abcd80aa86df31be68fe48


struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}

