import SwiftUI

struct SpendingDetailView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var auto: String = ""
    @State var food: String = ""
    @State var entertainment: String = ""
    @State var bills: String = ""

    var body: some View {
        ZStack(){
            Rectangle()
                .fill(Color(red: 240/255, green: 240/255, blue: 240/255))
                .ignoresSafeArea()
            VStack(){
                HStack(){
                    Button(action: { viewRouter.currentPage = .page3; } ) {
                        Image(systemName: "chevron.backward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    .padding(.leading, 15)
                    Spacer()
                    Text("Spending").font(.title3).bold()
                    Spacer()
                    Button(action: { print("dot menu clicked" )} ) {
                        Image(systemName: "ellipsis")
                            .imageScale(.large)
                            .rotationEffect(.degrees(90))
                            .foregroundColor(Color(.black))
                    }
                    .padding(.trailing, 15)
                }
                PieView()
                    .padding(.top, 30)
                Spacer()
                DetailView()
                    .padding(.top, 30)
            }
            .padding(.top, 20)
        }
    }
    
}

struct PieView : View {
    var body : some View {
        ZStack(){
            
            Circle()
                .trim(from: 0.0, to: 0.3)
                .stroke(Color(.systemTeal), lineWidth: 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0.3, to: 0.5)
                .stroke(Color(.systemYellow), lineWidth: 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0.5, to: 0.7)
                .stroke(Color(.systemPink), lineWidth: 50)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0.7, to: 1.0)
                .stroke(Color(.systemIndigo), lineWidth: 30)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
            VStack(){
                Text("28%")
                    .font(.title)

            }
        }
    }
}

struct DetailView : View {
    var body : some View {
        ZStack(){
            Rectangle()
                .fill(Color.white)
                .frame(width: 400, height: 500)
            VStack(){
                HStack(){
                    Button(action: { print("back button clicked" )} ) {
                        Image(systemName: "chevron.backward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    .padding(.leading, 15)
                    Spacer()
                    Text("Entertainment")
                        .font(.title3)
                        .bold()
                    Spacer()
                    Button(action: { print("back button clicked" )} ) {
                        Image(systemName: "chevron.forward")
                            .imageScale(.large)
                            .foregroundColor(Color(.black))
                    }
                    .padding(.trailing, 15)
                }
                Divider()
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 20)
        }
    }
    
}

struct SpendingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingDetailView()
    }
}
