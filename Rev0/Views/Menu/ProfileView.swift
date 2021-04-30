import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    
    var body: some View {
        
        ZStack(alignment:.top){
            VStack{
                Image("header").frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 165)
                Rectangle()
                    .fill(Color(.systemGray6))
            }
            VStack(){
                HStack{
                    Button(action: { viewRouter.currentPage = .page3; } ) {
                        Image(systemName: "chevron.backward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    Spacer()
                }
                .padding(.top, 70)
                
                
                    VStack{
                        ZStack{
                            Circle()
                                .fill(Color(.white))
                                .frame(width:150, height:150)
                        Image("memoji")
                            .resizable()
                            .frame(width:150, height:150)
                        }
                        HStack{
                            Text(" Signed Up \n04/28/2021")
                                .font(.callout)
                            Spacer()
                            Text("Total Saved \n $4056.34")
                                .font(.callout)
                        }
                        Text("John Doe")
                            .font(.title)
                            .padding(.top,20)
                        Text("Gold Status")
                            .padding(.top,10)

            
                }
                Separator()
                HStack{
                    Text("Your Banks")
                    .font(.title3)
                    Spacer()
                }
                
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(.all)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

