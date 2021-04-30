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
    @State var alertMessage: String?
    
    
    var body: some View {
        VStack(spacing: 20){
            Image("b")
                .resizable()
                .frame(width: 150, height: 150)
                .padding(.top, 130)
            
            InputField(input: $fullname, placeholder: "Name", icon: "person")
            InputField(input: $email, placeholder: "Email", icon: "envelope")
            SecureInputField(password: $password, placeholder: "Password", icon: "lock")
            SecureInputField(password: $confirmPassword, placeholder: "Confirm Password", icon: "lock")
            VStack {
                Button(action: { withAnimation { viewRouter.currentPage = .page2 } }) { Text("Already have an account? Sign In").font(.custom("DIN Alternate Bold", size: 16)).foregroundColor(blue)}
                    .padding(.top, 10)
                Spacer()
                VStack(){
                    Text("Continue With")
                        .font(.custom("DIN Alternate Bold", size: 18))
                    HStack(alignment: .center, spacing: 20){
                        Image("google")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Image("apple")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                        Image("fb")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                Spacer()
            }
            ZStack(){
                AuthButtonBG()
                    .shadow(color: .white, radius: 1)
                Button(action:{ signup()})
                { Text("Sign Up").font(.body).foregroundColor(.white)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Sign Up Error"), message: Text(alertMessage ?? "Error signing up. Please Try again."), dismissButton: .default(Text("Dismiss")))
                    }
                    .disabled(fullname.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty)}
                .sheet(isPresented: $showLink, onDismiss:  {                     UserDefaults.standard.set(fullname, forKey: "name"); viewRouter.currentPage = .page3 }) {
                    LinkView()
                }
            }
            .padding(.bottom, 70)
        }
        .background(Image("AuthBG").resizable())
        .ignoresSafeArea()
    }
    
    func signup() {
        if(password != confirmPassword){
            self.showingAlert = true;
            self.alertMessage = "Passwords don't match, please try again.";
        }
        else {
            UserDefaults.standard.setValue(fullname, forKey: "name")
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    self.alertMessage = error?.localizedDescription ?? "Error signing up. Please Try again.";
                    self.showingAlert = true;
                } else {
                    self.showLink = true;
                    UserDefaults.standard.set(true, forKey: "logged_in")
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
