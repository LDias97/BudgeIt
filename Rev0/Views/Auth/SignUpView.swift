import SwiftUI
import Firebase

struct SignUpView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var fullname: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var showLink = false
    @State var showingAlert: Bool = false
    
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
            InputField(input: $fullname, placeholder: "Full Name", icon: "person")
                .padding(.top, 20)
            InputField(input: $email, placeholder: "Email", icon: "envelope")
            SecureInputField(password: $password, placeholder: "Password", icon: "lock")
            SecureInputField(password: $confirmPassword, placeholder: "Confirm Password", icon: "lock.rotation")
            
            VStack(spacing: 15){
                ZStack(){
                    AuthButtonBG()
                    Button(action:{ signup(); UserDefaults.standard.set(0.0, forKey: "lastMonthBalance"); UserDefaults.standard.set(false, forKey: "balanceRetrieved");})
                        { Text("Sign Up").font(.body).foregroundColor(.white)}
                        .disabled(password.isEmpty || email.isEmpty || confirmPassword.isEmpty || fullname.isEmpty)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Sign Up Error"), message: Text("Error creating account. \nPlease try again."), dismissButton: .default(Text("Dismiss")))
                        }
                        .sheet(isPresented: $showLink){
                            LinkView()
                        }
                }
                ZStack{
                    AuthButtonBG()
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
                self.showingAlert = true;
            } else {
                if(password == confirmPassword){
                    self.showLink = true;
                    UserDefaults.standard.set(true, forKey: "logged_in")
                    print("sign up = success")
                }
                else{
                    self.showingAlert = true;
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
