import Foundation
import SwiftUI

let grey = Color(red: 240/255, green: 240/255, blue: 240/255)
let darkPurple = Color(red: 96/255, green: 96/255, blue: 235/255)
let lightPurple = Color(red: 177/255, green: 127/255, blue: 248/255)
let red = Color(red: 220/255, green: 104/255, blue: 101/255)
let green = Color(red: 87/255, green: 210/255, blue: 150/255)

struct backButton: View {
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

struct ellipsisButton: View {
    var body : some View {
        Button(action: { print("dot menu clicked" )} ) {
            Image(systemName: "ellipsis")
                .imageScale(.large)
                .rotationEffect(.degrees(90))
                .foregroundColor(Color(.black))
        }
    }
}

