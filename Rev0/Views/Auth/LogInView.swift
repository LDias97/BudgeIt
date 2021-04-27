import SwiftUI
import Firebase

struct LogInView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var email: String = ""
    @State var password: String = ""
    @State var showingAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 20){
            VStack(spacing: 5){
                Image("b")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding(.top, 130)
            }
            
            InputField(input: $email, placeholder: "Email", icon: "envelope")
            SecureInputField(password: $password, placeholder: "Password", icon: "lock")
                .padding(.top, 10)
            VStack {
                Button(action: { withAnimation { viewRouter.currentPage = .page1 } }) { Text("Don't have an account? Sign Up").font(.custom("DIN Alternate Bold", size: 16)).foregroundColor(blue)}
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
                Button(action:{  login(); }) { Text("Sign In").font(.body).foregroundColor(.white)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Sign In Error"), message: Text("Incorrect email or password. \nPlease try again."), dismissButton: .default(Text("Dismiss")))
                    }
                }.disabled(password.isEmpty || email.isEmpty)
            }
            .padding(.bottom, 42)
            Spacer()
        }
        .background(Image("AuthBG").resizable())
        .ignoresSafeArea()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                showingAlert = true
            } else {
                UserDefaults.standard.set(true, forKey: "logged_in")
                withAnimation { viewRouter.currentPage = .page3 }
            }
        }
    }
    
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
