import SwiftUI
import Firebase
import FirebaseAuth

struct MenuView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var showMenu: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(){
                VStack(alignment: .center){
                    Image("b")
                        .resizable()
                        .frame(width:150, height:150)
                        .padding(.top, 70)
                    VStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color(.systemGray3))
                            .frame(height: 1)
                            .padding(.top, 30)
                        Button(action: { viewRouter.currentPage = .page8; } ){
                            HStack {
                                Image(systemName: "person")
                                    .foregroundColor(darkPurple)
                                    .imageScale(.medium)
                                    .padding(.trailing, 10)
                                Text("Profile")
                                    .foregroundColor(Color(.darkGray))
                                    .font(.body)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.darkGray))
                                    .imageScale(.small)
                            }
                        }
                        .padding(.top, 50)
                        Button(action: { viewRouter.currentPage = .page7; } ) {
                            HStack {
                                Image(systemName: "bell")
                                    .foregroundColor(darkPurple)
                                    .imageScale(.medium)
                                    .padding(.trailing, 10)
                                Text("Notifications")
                                    .foregroundColor(Color(.darkGray))
                                    .font(.body)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.darkGray))
                                    .imageScale(.small)
                            }
                        }
                        .padding(.top, 50)
                        Button(action: { viewRouter.currentPage = .page9;} ) {
                            HStack {
                                Image(systemName: "gearshape")
                                    .foregroundColor(darkPurple)
                                    .imageScale(.medium)
                                    .padding(.trailing, 10)
                                Text("Settings")
                                    .foregroundColor(Color(.darkGray))
                                    .font(.body)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.darkGray))
                                    .imageScale(.small)
                            }
                        }
                        .padding(.top, 50)
                        Button(action: { viewRouter.currentPage = .page10;} ) {
                            HStack {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(darkPurple)
                                    .imageScale(.medium)
                                    .padding(.trailing, 10)
                                Text("Help")
                                    .foregroundColor(Color(.darkGray))
                                    .font(.body)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.darkGray))
                                    .imageScale(.small)
                            }
                        }
                        .padding(.top, 50)
                        Rectangle()
                            .fill(Color(.systemGray3))
                            .frame(height: 1)
                            .padding(.top,50)
                        Button(action: {
                                do{
                                    try Auth.auth().signOut();
                                    UserDefaults.standard.set(false, forKey: "logged_in")
                                    viewRouter.currentPage = .page2;
                                }
                                catch{
                                    debugPrint(error.localizedDescription)
                                }}) {
                            HStack {
                                Image(systemName: "arrow.down.left.circle")
                                    .foregroundColor(darkPurple)
                                    .imageScale(.medium)
                                    .padding(.trailing, 10)
                                Text("Log Out")
                                    .foregroundColor(Color(.darkGray))
                                    .font(.body)
                                Spacer()
                            }
                        }
                        .padding(.top, 50)
                        Spacer()
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                }
                .frame(width: UIScreen.main.bounds.width*0.6, height:UIScreen.main.bounds.height)
                .background(Rectangle()
                                .fill(Color(.systemGray5))
                                .shadow(radius: 5))
            }
        }
    }
}
