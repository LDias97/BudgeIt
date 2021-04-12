import SwiftUI

struct HelpView: View {
    
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
                    Text("Help")
                        .font(.title)
                    Spacer()
                }
                .padding(.top, 70)
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}

