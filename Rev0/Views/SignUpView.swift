import SwiftUI
import Firebase

struct SignUpView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var fullname: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var showLink = false
    
    var body: some View {
        VStack(spacing: 20){
            VStack(){
                Image("b")
                    .resizable()
                    .frame(width:175, height:175)
                    .padding(.top,30)
                Text("Sign Up")
                    .font(.largeTitle)
                    .bold()
            }
            ZStack{
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(width: 370, height: 60)
                    .cornerRadius(30.0)
                HStack{
                    Image(systemName: "person")
                        .foregroundColor(Color(.systemGray2))
                    TextField("Full Name", text: $fullname)
                }
                .padding(.leading, 15)
            }
            .padding(.top, 20)
            .padding(.leading, 30)
            .padding(.trailing, 30)
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
            ZStack{
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(width: 370, height: 60)
                    .cornerRadius(30.0)
                HStack{
                    Image(systemName: "lock.rotation")
                        .foregroundColor(Color(.systemGray2))
                    SecureField("Confirm Password", text: $confirmPassword)
                }
                .padding(.leading, 15)
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            
            ZStack(){
                VStack(spacing: 20){
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [ darkPurple,Color(.blue)]), startPoint: .trailing, endPoint: .leading))
                        .frame(width: 370, height: 60)
                        .cornerRadius(30.0)
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [ darkPurple,Color(.blue)]), startPoint: .trailing, endPoint: .leading))
                        .frame(width: 370, height: 60)
                        .cornerRadius(30.0)
                }
                VStack(spacing: 60){
                    Button(action:{ signup(); self.showLink = true;  }) { Text("Sign Up").font(.body).foregroundColor(.white) }
                        .sheet(isPresented: $showLink){
                            LinkView()
                        }
                    Button(action:{print("Clicked Continue with Google")}) { Text("Continue with Google").font(.body).foregroundColor(.white) }
                }
            }
            Button(action:{ viewRouter.currentPage = .page2;}) { Text("Already have an account? Sign In").font(.body).foregroundColor(.blue) }
        }
    }
    
    func signup() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                if(password == confirmPassword){
                    UserDefaults.standard.set(true, forKey: "logged_in")
                    print("sign up = success")
                }
                else{
                    print("Passwords don't match, please try again.")
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
