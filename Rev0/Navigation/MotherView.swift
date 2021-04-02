import SwiftUI

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
            LinkView()
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
                    .environmentObject(BankAccountViewModel())
    }
}

