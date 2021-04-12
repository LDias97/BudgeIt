import Foundation
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
        ZStack{
            Rectangle()
                .fill(Color(.systemGray5))
                .frame(width: 370, height: 60)
                .cornerRadius(30.0)
            HStack{
                Image(systemName: icon)
                    .foregroundColor(Color(.systemGray2))
                TextField(placeholder, text: $input)
            }
            .padding(.leading, 15)
        }
        .padding(.leading, 30)
        .padding(.trailing, 30)
    }
}

struct SecureInputField: View {
    @Binding var password: String
    @State var placeholder: String
    @State var icon: String
    
    var body : some View {
        ZStack{
            Rectangle()
                .fill(Color(.systemGray5))
                .frame(width: 370, height: 60)
                .cornerRadius(30.0)
            HStack{
                Image(systemName: icon)
                    .foregroundColor(Color(.systemGray2))
                SecureField(placeholder, text: $password)
            }
            .padding(.leading, 15)
        }
        .padding(.leading, 30)
        .padding(.trailing, 30)
    }
}

struct AuthButtonBG: View {
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [ darkPurple,Color(.blue)]), startPoint: .trailing, endPoint: .leading))
                .frame(width: 370, height: 60)
                .cornerRadius(30.0)
        }
        
    }
}

struct Card: View {
    @State var width: CGFloat = 0
    @State var height: CGFloat = 0
    
    var body : some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color.white)
            .frame(width: width, height: height)
            .shadow(color: Color.gray.opacity(0.25), radius: 5, x: 0, y: 0)
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
    @State var percentage: CGFloat
    @State var color: Color
    @State var iconName: String
    
    var body : some View {
        ZStack(){
            Circle()
                .stroke(Color(.systemGray6), lineWidth: 3)
                .frame(width: 40, height:40)
            Circle()
                .trim(from: 0, to: percentage)
                .stroke(color, lineWidth: 3)
                .frame(width: 40, height:40)
                .rotationEffect(.degrees(-90))
            Image(systemName: iconName)
                .foregroundColor(Color(.systemGray3))
        }
    }
    
}
