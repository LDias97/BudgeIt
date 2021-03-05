import SwiftUI

enum Page {
    case page1 // SignUp
    case page2 // LogIn
    case page3 // Dashboard
    case page4 // Spending
    case page5 // BudgeIt
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
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}

