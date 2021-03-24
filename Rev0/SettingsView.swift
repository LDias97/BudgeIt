import SwiftUI

struct SettingsView: View {
    
    @State var isEnabled1: Bool = false
    @State var isEnabled2: Bool = false
    @State var isEnabled3: Bool = false
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        
        ZStack(alignment:.top){
            Rectangle()
                .fill(Color(.systemGray6))
            VStack(){
                Spacer()
                HStack{
                    Toggle("Option1", isOn: $isEnabled1)
                }
                HStack{
                    Toggle("Option2", isOn: $isEnabled1)
                }
                HStack{
                    Toggle("Option3", isOn: $isEnabled1)
                }
                HStack{
                    Text("Manage Bank Accounts")
                    Spacer()
                    Button(action: { viewRouter.currentPage = .page11; } ) {
                        Image(systemName: "chevron.forward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                            .padding(.top)
                    }
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

