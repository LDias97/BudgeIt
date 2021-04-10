import Foundation
import SwiftUI

let grey = Color(red: 240/255, green: 240/255, blue: 240/255)
let darkPurple = Color(red: 96/255, green: 96/255, blue: 235/255)
let lightPurple = Color(red: 177/255, green: 127/255, blue: 248/255)
let red = Color(red: 220/255, green: 104/255, blue: 101/255)
let green = Color(red: 87/255, green: 210/255, blue: 150/255)

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

