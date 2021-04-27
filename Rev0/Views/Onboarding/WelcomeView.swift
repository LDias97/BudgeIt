import SwiftUI

struct WelcomeView: View {
    @State var slide: Int = 1
    @State var skip: Bool = false
    @EnvironmentObject var viewRouter: ViewRouter
    @State var left : CGFloat = -(UIScreen.main.bounds.width)
    @State var center : CGFloat = (UIScreen.main.bounds.width)/1.1
    @State var right : CGFloat = (UIScreen.main.bounds.width)/2
    @State var leftRight : Bool = false
    @State var offset : CGFloat = UIScreen.main.bounds.width
    @State var degrees: Double = 0.0

    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width > -100 {
                    withAnimation {
                        if(self.slide != 1){
                            self.slide -= 1
                            self.offset += UIScreen.main.bounds.width
                        }
                    }
                }
                else if $0.translation.width < 100 {
                    withAnimation {
                        if(self.slide != 3){
                            self.slide += 1
                            self.offset -= UIScreen.main.bounds.width
                        }
                    }
                }
            }
        
        ZStack{
            Image("bg")
            HStack(alignment: .center, spacing: 42.5)
            {
                SlideOne(slide: $slide, offset: $offset)
                SlideTwo(slide: $slide, offset: $offset)
                SlideThree(slide: $slide, offset: $offset)
            }
            .offset(x: offset)
            ProgressDots(slide: $slide)
                .padding(.top, 130)
        }
        .gesture(drag)
        
        .ignoresSafeArea()
    }
    
}

struct SlideOne: View {
    @Binding var slide: Int
    @Binding var offset: CGFloat
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
            Text("Welcome to BudgeIt!")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.custom("DIN Alternate Bold", size: 30))
            Spacer()
            Image("bag")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.top, 10)
            Spacer()
            Text("Budgeting made simple.")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.custom("DIN Alternate Bold", size: 20))
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.bottom, 27)
                .padding(.top, 75)
            Spacer()
            Button(action: { withAnimation { slide = 2; offset -= UIScreen.main.bounds.width; } }) {
                ZStack{
                    Rectangle()
                        .fill(Color(.white).opacity(0.3))
                        .frame(width: 370, height: 60)
                        .cornerRadius(30.0)
                    Text("Next")
                        .font(.custom("DIN Alternate Bold", size: 20))
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom)
            Button(action: {  withAnimation { slide = 3; offset -= UIScreen.main.bounds.width * 2; } }){
                Text("Skip")
                    .foregroundColor(.white)
            }
        }
        .padding(.top, 200)
        .padding(.bottom, 145)
    }
}

struct SlideTwo: View {
    @Binding var slide: Int
    @Binding var offset: CGFloat
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
            Text("Save smarter, not Harder.")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.custom("DIN Alternate Bold", size: 30))
            Spacer()
            Image("piggyBank")
                .resizable()
                .frame(width: 170, height: 230)
                .padding(.top, 10)
            Spacer()
            Text("Getting your finances under control \ndoesn't have to be difficult.")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.custom("DIN Alternate Bold", size: 20))
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.bottom, 27)
                .padding(.top, 75)
            Spacer()
            Button(action: { withAnimation { slide = 3; offset -= UIScreen.main.bounds.width; } }) {
                ZStack{
                    Rectangle()
                        .fill(Color(.white).opacity(0.3))
                        .frame(width: 370, height: 60)
                        .cornerRadius(30.0)
                    Text("Next")
                        .font(.custom("DIN Alternate Bold", size: 20))
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom)
            Button(action: {  withAnimation { slide = 3; offset -= UIScreen.main.bounds.width; } }){
                Text("Skip")
                    .foregroundColor(.white)
            }
        }
        .padding(.top, 200)
        .padding(.bottom, 145)
    }
}



struct SlideThree: View {
    @Binding var slide: Int
    @Binding var offset: CGFloat
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Text("Powered by Plaid")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.custom("DIN Alternate Bold", size: 30))
                Color(.magenta)
                    .mask(
                        Image("plaidLogo")
                            .resizable()
                    )
                    .frame(width: 30, height: 30)
            }
            Spacer()
            Image("bank")
                .resizable()
                .frame(width: 250, height: 200)
                .padding(.top, 30)
                .padding(.bottom, 40)
            Spacer()
            Text("It’s your data. Let’s keep it that way.\n Plaid allows you to link bank accounts\nboth quickly and securely.")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.custom("DIN Alternate Bold", size: 20))
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .animation(.easeInOut)
            Spacer()
            Button(action: {  withAnimation { viewRouter.currentPage = .page1 } } ) {
                ZStack{
                    Rectangle()
                        .fill(Color(.white).opacity(0.3))
                        .frame(width: 370, height: 60)
                        .cornerRadius(30.0)
                    Text("Get Started")
                        .font(.custom("DIN Alternate Bold", size: 20))
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom)
            Button(action: {  withAnimation { viewRouter.currentPage = .page2 } }){
                Text("Already have an account? Sign In")
                    .foregroundColor(.white)
            }
        }
        .padding(.top, 140)
        .padding(.bottom, 145)
    }
}

struct ProgressDots: View {
    @Binding var slide: Int
    var body: some View {
        HStack{
            Circle()
                .foregroundColor(.white)
                .frame(width: slide == 1 ? 7 : 5, height: slide == 1 ? 7 : 5)
            Circle()
                .foregroundColor(.white)
                .frame(width: slide == 2 ? 7 : 5, height: slide == 2 ? 7 : 5)
            Circle()
                .foregroundColor(.white)
                .frame(width: slide == 3 ? 7 : 5, height: slide == 3 ? 7 : 5)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
