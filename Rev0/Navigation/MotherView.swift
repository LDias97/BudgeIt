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
    case page11 // LinkView
    case page12 // LaunchScreen
    case page13 // OnBoarding
}

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userData: UserData
    @State var showLink: Bool = false
    @State var loading: Bool = true
    
    
    var body: some View {
        switch viewRouter.currentPage{
        case .page1:
            SignUpView()
        case .page2:
            LogInView()
        case .page3:
            if(userData.hasLoaded){
                DashboardView()
            }
            else{
                DashboardView().onAppear {
                    userData.load();
                }
            }
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
        case .page12:
            Emblem()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation() {
                            viewRouter.currentPage = (UserDefaults.standard.value(forKey: "logged_in") ?? false) as! Bool ? .page13 : .page13
                        }
                    }
                }
        case .page13:
            WelcomeView()
        }
    }
    
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
            .environmentObject(UserData())
    }
}

