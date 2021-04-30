import SwiftUI

struct BackButton: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var page: Page
    var body : some View {
        Button(action: { withAnimation{viewRouter.currentPage = page;}} ) {
            Image(systemName: "chevron.backward")
                .imageScale(.large)
                .foregroundColor(Color(.black))
        }
    }
}

struct EllipsisButton: View {
    var body : some View {
        Button(action: { print("dot menu clicked" )} ) {
            Image(systemName: "ellipsis")
                .imageScale(.large)
                .rotationEffect(.degrees(90))
                .foregroundColor(Color(.black))
        }
    }
}

struct InputField: View {
    @Binding var input: String
    @State var placeholder: String
    @State var icon: String
    
    var body : some View {
        VStack(){
            HStack{
                Text(placeholder)
                    .font(.custom("DIN Alternate Bold", size: 14))
                    .foregroundColor(Color(.systemGray2))
                Spacer()
            }
            HStack{
                    TextField("", text: $input)
                    Spacer()
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.systemGray2))
        }
        .padding(.leading, 60)
        .padding(.trailing, 60)
    }
}

struct SecureInputField: View {
    @Binding var password: String
    @State var placeholder: String
    @State var icon: String
    
    var body : some View {
        VStack(){
            HStack{
                Text(placeholder)
                    .font(.custom("DIN Alternate Bold", size: 14))
                    .foregroundColor(Color(.systemGray2))
                Spacer()
            }
            HStack{
                    SecureField("", text: $password)
                    Spacer()
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.systemGray2))
        }
        .padding(.leading, 60)
        .padding(.trailing, 60)
    }
}

struct AuthButtonBG: View {
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [ darkPurple,teal]), startPoint: .leading, endPoint: .trailing))
            .frame(width: 370, height: 60)
            .cornerRadius(30.0)
    }
}

struct Card: View {
    @State var width: CGFloat = 0
    @State var height: CGFloat = 0
    
    var body : some View {
        if(width == 0 && height == 0){
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.25), radius: 5, x: 0, y: 0)
                .padding(.leading, 20)
                .padding(.trailing, 20)
        }
        else {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white)
                .frame(width: width, height: height)
                .shadow(color: Color.gray.opacity(0.25), radius: 5, x: 0, y: 0)
                .padding(.leading, 20)
                .padding(.trailing, 20)
        }
    }
    
}

struct Divider: View {
    var body : some View {
        Rectangle()
            .fill(Color(.systemGray6))
            .frame(height: 1)
    }
}

struct ProgressCircle: View {
    @State var end: CGFloat = 0
    @State var percentage: CGFloat
    @State var color: Color
    @State var iconName: String
    
    var body : some View {
        ZStack(){
            Circle()
                .stroke(Color(.systemGray6), lineWidth: 3)
                .frame(width: 40, height:40)
            Circle()
                .trim(from: 0, to: self.end)
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .fill(color)
                .frame(width: 40, height:40)
                .rotationEffect(.degrees(-90))
                .animation(.spring(response: 2.0))
                .onAppear() {
                    withAnimation {
                        self.end = self.percentage
                    }
                }
            Image(systemName: iconName)
                .foregroundColor(Color(.systemGray3))
        }
    }
}

struct Slice: View {
    @State var offset: CGFloat
    @State var percentage: CGFloat
    @State var color: Color
    @State var isSelected: Bool
    
    var body : some View {
        Circle()
            .trim(from: offset, to: offset + percentage)
            .stroke(color, lineWidth: isSelected ? 50 : 30)
            .frame(width: 200, height: 200)
            .rotationEffect(.degrees(-90))
    }
    
}

struct DefaultCell : View {
    var body: some View {
        HStack(){
            HStack(){
                Rectangle()
                    .foregroundColor(grey)
                    .frame(width: 3, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10.0)
                VStack(alignment: .leading, spacing:5){
                    Rectangle()
                        .foregroundColor(grey)
                        .frame(width: 50, height: 3)
                        .cornerRadius(3)
                    HStack(){
                        Rectangle()
                            .foregroundColor(grey)
                            .frame(width: 100, height: 3)
                            .cornerRadius(3)
                    }
                }
                .padding(.leading, 5)
            }
            Spacer()
            VStack(spacing: 5){
                HStack(){
                    Spacer()
                    Rectangle()
                        .foregroundColor(grey)
                        .frame(width: 20, height: 3)
                        .cornerRadius(3)
                }
                HStack(){
                    Spacer()
                    Rectangle()
                        .foregroundColor(grey)
                        .frame(width: 40, height: 3)
                        .cornerRadius(3)
                }
            }
        }
        Divider()
    }
}

struct Emblem : View {
    @State private var degrees: Double = 0.0
    
    var body: some View {
        
        ZStack{
            
            Rectangle()
                .foregroundColor(Color(.white))
                .scaledToFit()
            Image("b")
                .resizable()
                .frame(width: 180, height: 180)
                .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
                .animation(Animation.linear(duration: 3.0).repeatForever(autoreverses: false))
                .onAppear() {
                    withAnimation {
                        self.degrees +=  360
                    }
                }
        }
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(.all)
    }
}

struct GenericViews_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Emblem()
        }
    }
}


