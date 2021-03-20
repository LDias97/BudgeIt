import SwiftUI
import Firebase

struct LogInView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing: 20){
            VStack(){
            Image("b")
                .resizable()
                .frame(width:175, height:175)
                .padding(.top, 30)
            Text("Sign In")
                .font(.largeTitle)
                .bold()
            }
            ZStack{
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(width: 370, height: 60)
                    .cornerRadius(30.0)
                HStack{
                    Image(systemName: "envelope")
                        .foregroundColor(Color(.systemGray2))
                    TextField("Email", text: $email)
                }
                .padding(.leading, 15)
            }
            .padding(.top, 35)
            .padding(.leading, 30)
            .padding(.trailing, 30)
            ZStack{
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(width: 370, height: 60)
                    .cornerRadius(30.0)
                HStack{
                    Image(systemName: "lock")
                        .foregroundColor(Color(.systemGray2))
                    SecureField("Password", text: $password)
                }
                .padding(.leading, 15)
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            
            ZStack(){
                VStack(spacing: 15){
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [ darkPurple,Color(.blue)]), startPoint: .trailing, endPoint: .leading))
                    .frame(width: 370, height: 60)
                    .cornerRadius(30.0)
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [ darkPurple,Color(.blue)]), startPoint: .trailing, endPoint: .leading))
                    .frame(width: 370, height: 60)
                    .cornerRadius(30.0)
                }
            VStack(spacing: 55){
                Button(action:{  login(); viewRouter.currentPage = .page3; }) { Text("Sign In").font(.body).foregroundColor(.white)}
                    Button(action:{print("Clicked Continue with Google")}) {Text("Continue with Google").font(.body).foregroundColor(.white) }
                }
            }
            Button(action:{ viewRouter.currentPage = .page1; }) { Text("Don't have an account? Sign Up").font(.body).foregroundColor(.blue)}
                .padding(.top, 25)
            Spacer()
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
