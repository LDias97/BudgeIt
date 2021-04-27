import SwiftUI

struct ProfileView: View {

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
                    Text("Profile")
                        .font(.title)
                    Spacer()
                }
                .padding(.top, 70)
                
                HStack{
                Text("Name")
                    .padding(.top, 100)
                    Spacer()
                }
                
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

