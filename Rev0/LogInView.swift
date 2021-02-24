import SwiftUI

struct LogInView: View {
    @State var fullname: String = ""
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""

    var body: some View {
        NavigationView {
            ZStack(){
                Rectangle()
                    .fill(Color(red: 240/255, green: 240/255, blue: 240/255))
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 420, height: 80)
                    .padding(.bottom, 700)
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 390, height: 550)
        VStack(spacing: 40){
            HStack(spacing:140){
                Button(action:{ print("Clicked Sign Up")}) { Text("Sign Up").font(.body).foregroundColor(.white).padding(.top, 30)}
                Button(action:{print("Clicked Sign In")}) {Text("Sign In").font(.body).foregroundColor(.white).padding(.top, 30) }
                }
            Spacer()
            TextField("Full name", text: $fullname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            ZStack(){
                VStack(spacing: 15){
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 370, height: 50)
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 370, height: 50)
                }
            VStack(spacing: 45){
                Button(action:{ print("Clicked Sign Up")}) { Text("Sign Up")
                        .font(.body)
                        .foregroundColor(.white)}
                Button(action:{print("Clicked Continue with Google")}) {
                    Text("Continue with Google")
                        .font(.body)
                        .foregroundColor(.white)
                }
                }
            }
            Spacer()
            Text("By clicking Create An Account, you agree to our Terms of Services.").font(.callout).multilineTextAlignment(.center)
        }
        .padding(.leading, 25)
        .padding(.trailing, 25)
            }
        .navigationBarItems(leading: (
                            Button(action: {}) {
                                Image(systemName: "line.horizontal.3")
                                    .imageScale(.large)
                            }),
                            trailing: (
                            Button(action: {}) {
                                Image(systemName: "magnifyingglass")
                                    .imageScale(.large)
                            }))
        .navigationBarTitle("Welcome", displayMode: .inline)


        }
        
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
