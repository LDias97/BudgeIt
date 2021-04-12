import SwiftUI
import Firebase

struct LogInView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var email: String = ""
    @State var password: String = ""
    @State var showingAlert: Bool = false
    
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
            
            InputField(input: $email, placeholder: "Email", icon: "envelope")
                .padding(.top, 35)
            SecureInputField(password: $password, placeholder: "Password", icon: "lock")
            
            VStack(spacing: 15){
                ZStack(){
                    AuthButtonBG()
                    Button(action:{  login(); }) { Text("Sign In").font(.body).foregroundColor(.white)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Sign In Error"), message: Text("Incorrect email or password. \nPlease try again."), dismissButton: .default(Text("Dismiss")))
                        }
                    }.disabled(password.isEmpty || email.isEmpty)
                }
                ZStack(){
                    AuthButtonBG()
                    Button(action:{print("Clicked Continue with Google")}) {Text("Continue with Google").font(.body).foregroundColor(.white) }.disabled(password.isEmpty || email.isEmpty)
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
                showingAlert = true
            } else {
                UserDefaults.standard.set(true, forKey: "logged_in")
                viewRouter.currentPage = .page3
            }
        }
    }
    
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
