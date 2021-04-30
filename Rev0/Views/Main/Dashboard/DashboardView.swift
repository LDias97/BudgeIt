import SwiftUI
import Firebase

struct DashboardView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userData: UserData
    @State var showMenu = false
    @State var editBudgets = false
    @State var viewCharts = true
    @State var showAlert = false

    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        GeometryReader { geometry in
            ZStack(){
                ScrollView{
                    ZStack(alignment:.top){
                        Rectangle()
                            .fill(Color(.systemGray6))
                        Image("header")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.bottom, geometry.size.height+350)
                            .frame(width: geometry.size.width+1, height: geometry.size.height)
                        VStack(spacing: 30){
                            ZStack(alignment:.top){
                                VStack(){
                                    HStack(){
                                        Button(action: { withAnimation(.default) {
                                            self.showMenu.toggle(); }
                                        } ) {
                                            Image(systemName: "line.horizontal.3")
                                                .imageScale(.large)
                                                .foregroundColor(Color(.white))
                                        }
                                        .padding(.leading, 30)
                                        Spacer()
                                        Button(action: { withAnimation(.default) {
                                            self.showMenu.toggle(); }
                                        } ) {
                                            Image(systemName: "bell.badge")
                                                .imageScale(.large)
                                                .foregroundColor(Color(.white))
                                        }
                                        .padding(.trailing, 30)
                                    }
                                    HStack(){
                                        Text("Dashboard")
                                            .font(.custom("DIN Alternate Bold", size: 30))
                                            .foregroundColor(Color(.white))
                                        Spacer()
                                    }
                                    .padding(.leading, 30)
                                    .padding(.top, 20)
                                }
                                .padding(.top, 20)
                                NetWorthCardView(viewModel: NetWorthViewModel(userData: userData))
                            }
                            .padding(.top, 44)
                            BudgetCardView(viewModel: BudgetViewModel(userData: userData), showingAlert: $showAlert)
                            SpendingCardView()
                                .onTapGesture {
                                    withAnimation{viewRouter.currentPage = .page4;}
                                }
                            IncomeCardView()
                                .foregroundColor(.black)
                                .onTapGesture {
                                    withAnimation{viewRouter.currentPage = .page6;}
                                }
                            BarChartDashView(viewCharts: $viewCharts)
                                .padding(.bottom, 35)
                        }
                    }
                }
                .background(
                    Rectangle()
                        .fill(Color(.systemGray6))
                )
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                HStack(){
                    MenuView(showMenu: $showMenu)
                        .offset(x: self.showMenu ? 0 : 0 - (UIScreen.main.bounds.width))
                        .background(Color.primary.opacity(self.showMenu ? 0.6 : 0))
                        .ignoresSafeArea()
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .gesture(drag)
        .gesture(DragGesture(minimumDistance: 0).onEnded({ (value) in
            if (value.location.x > UIScreen.main.bounds.width*0.6){
                withAnimation {
                    self.showMenu = false
                }
            }
        }))
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView()
        }
    }
}
