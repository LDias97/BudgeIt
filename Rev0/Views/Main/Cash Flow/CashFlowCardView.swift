import SwiftUI

struct BarChartDashView: View {
    @State var selectedMonth: Int = 0
    //    var incomeValue: Double = 0.0
    //    var spendingValue: Double = 0.0
    //    var difference: Double = 0.0 // income - spending, cast to string
    //    var id: Int = 0
    @Binding var viewCharts: Bool
    @State var degrees: Double = 0
    
    var body : some View {
        ZStack() {
            if !viewCharts {
                ZStack(){
                    Card(width: 375, height: 450)
                    VStack() {
                        HStack(){
                            Text("Cash Flow")
                                .font(Font.custom("DIN Alternate Bold", size: 20))
                            Spacer()
                            Button(action: { self.viewCharts = true;
                                    withAnimation { self.degrees += 180;} }) {
                                Image(systemName: "chevron.forward")
                                    .imageScale(.medium)
                                    .foregroundColor(Color(.black))
                            }
                        }
                        .padding(.leading, 30)
                        .padding(.trailing, 20)
                        .padding(.top, 20)
                        BarChartView(selectedMonth: $selectedMonth)
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                }
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            else {
                ZStack(alignment: .top){
                    Card(width: 375, height: 450)
                    VStack(spacing: 10) {
                        HStack(){
                            Text("Categories")
                                .font(Font.custom("DIN Alternate Bold", size: 20))
                            Spacer()
                            Button(action: {self.viewCharts = false;
                                    withAnimation { self.degrees -= 180;} }) {
                                Image(systemName: "chevron.forward")
                                    .imageScale(.medium)
                                    .foregroundColor(Color(.black))
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.top, 20)
                        CategoryCharts()
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                }
            }
        }
        .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut)
    }
}


struct CategoryCharts: View {
    
    @State var i: Int = 0
    @State var j: Int = 3
    @State var wmy: Int = 1
    //@Binding var viewCharts: Bool
    @State var degrees: Double = 180
    let months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    var body: some View {
        VStack(){
            HStack(spacing: 15){
                Button(action: {wmy = 0;}){
                    ZStack{
                        Rectangle()
                            .fill(wmy == 0 ?
                                    (LinearGradient(gradient: Gradient(colors: [ darkPurple,Color(.blue)]), startPoint: .trailing, endPoint: .leading))
                                    :
                                    (LinearGradient(gradient: Gradient(colors: [ Color(.systemGray5)]), startPoint: .trailing, endPoint: .leading)))
                            .frame(width: 75, height: 40)
                            .cornerRadius(30)
                        Text("Week")
                            .foregroundColor(wmy == 0 ? Color(.white) : Color(.systemGray2))
                            .font((Font.custom("DIN Alternate Bold", size: 14)))
                    }
                }
                Button(action: {wmy = 1;}){
                    ZStack{
                        Rectangle()
                            .fill(wmy == 1 ?
                                    (LinearGradient(gradient: Gradient(colors: [ darkPurple,Color(.blue)]), startPoint: .trailing, endPoint: .leading))
                                    :
                                    (LinearGradient(gradient: Gradient(colors: [ Color(.systemGray5)]), startPoint: .trailing, endPoint: .leading)))
                            .frame(width: 75, height: 40)
                            .cornerRadius(30)
                        Text("Month")
                            .foregroundColor(wmy == 1 ? Color(.white) : Color(.systemGray2))
                            .font((Font.custom("DIN Alternate Bold", size: 14)))
                    }
                }
                Button(action: {wmy = 2;}){
                    ZStack{
                        Rectangle()
                            .fill(wmy == 2 ?
                                    (LinearGradient(gradient: Gradient(colors: [ darkPurple,Color(.blue)]), startPoint: .trailing, endPoint: .leading))
                                    :
                                    (LinearGradient(gradient: Gradient(colors: [ Color(.systemGray5)]), startPoint: .trailing, endPoint: .leading)))
                            .frame(width: 75, height: 40)
                            .cornerRadius(30)
                        Text("Year")
                            .foregroundColor(wmy == 2 ? Color(.white) : Color(.systemGray2))
                            .font((Font.custom("DIN Alternate Bold", size: 14)))
                    }
                }
            }
            Spacer()
            HStack(spacing: 40){
                Button(action: { print("Back clicked");}){
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color(.systemGray))
                }
                    ForEach(0..<3) { month in
                        HStack(){
                            VStack(){
                                Spacer()
                                ZStack(alignment: .bottom){
                                    HStack(alignment: .bottom, spacing: 5){
                                        Rectangle()
                                            .frame(width: 7, height: 100)
                                            .foregroundColor(Color(.systemGray5))
                                        Rectangle()
                                            .frame(width: 7, height:130)
                                            .foregroundColor(Color(.systemGray5))
                                        Rectangle()
                                            .frame(width: 7, height: 50)
                                            .foregroundColor(Color(.systemGray5))
                                        Rectangle()
                                            .frame(width: 7, height: 70)
                                            .foregroundColor(Color(.systemGray5))
                                    }
                                    HStack(alignment: .bottom, spacing: 5){
                                        Rectangle()
                                            .frame(width: 7, height: 60)
                                            .foregroundColor(Color(.blue))
                                        Rectangle()
                                            .frame(width: 7, height: 60)
                                            .foregroundColor(Color(.systemTeal))
                                        Rectangle()
                                            .frame(width: 7, height: 30)
                                            .foregroundColor(Color(.systemPink))
                                        Rectangle()
                                            .frame(width: 7, height: 50)
                                            .foregroundColor(Color(.systemOrange))
                                    }
                                }
                                .padding(.bottom, 10)
                                Text(months[month])
                                    .font((Font.custom("DIN Alternate Bold", size: 16)))
                        }
                    }
                }

                Button(action: { print("forward clicked");}){
                    Image(systemName: "chevron.forward")
                        .foregroundColor(Color(.systemGray))
                }
                
            }
            .padding(.bottom, 20)
            Spacer()
            Text("2021")
                .font((Font.custom("DIN Alternate Bold", size: 24)))
        }
        .padding(.top, 30)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .padding(.bottom, 20)
    }
}



//struct BarChartDashView_Previews: PreviewProvider {
//    @State var display = false
//    static var previews: some View {
//        BarChartDashView(viewCharts: $display)
//    }
//}

//VStack(){
//    Spacer()
//    ZStack(alignment: .bottom){
//        HStack(alignment: .bottom, spacing: 5){
//            Rectangle()
//                .frame(width: 7, height: 80)
//                .foregroundColor(Color(.systemGray5))
//            Rectangle()
//                .frame(width: 7, height: 100)
//                .foregroundColor(Color(.systemGray5))
//            Rectangle()
//                .frame(width: 7, height: 120)
//                .foregroundColor(Color(.systemGray5))
//            Rectangle()
//                .frame(width: 7, height: 90)
//                .foregroundColor(Color(.systemGray5))
//        }
//        HStack(alignment: .bottom, spacing: 5){
//            Rectangle()
//                .frame(width: 7, height: 70)
//                .foregroundColor(Color(.blue))
//            Rectangle()
//                .frame(width: 7, height: 60)
//                .foregroundColor(Color(.systemTeal))
//            Rectangle()
//                .frame(width: 7, height: 110)
//                .foregroundColor(Color(.systemPink))
//            Rectangle()
//                .frame(width: 7, height: 40)
//                .foregroundColor(Color(.systemOrange))
//        }
//    }
//    .padding(.bottom, 10)
//    Text("Apr")
//        .font((Font.custom("DIN Alternate Bold", size: 16)))
//}
//VStack(){
//    Spacer()
//    ZStack(alignment: .bottom){
//        HStack(alignment: .bottom, spacing: 5){
//            Rectangle()
//                .frame(width: 7, height: 100)
//                .foregroundColor(Color(.systemGray5))
//            Rectangle()
//                .frame(width: 7, height: 120)
//                .foregroundColor(Color(.systemGray5))
//            Rectangle()
//                .frame(width: 7, height: 90)
//                .foregroundColor(Color(.systemGray5))
//            Rectangle()
//                .frame(width: 7, height: 100)
//                .foregroundColor(Color(.systemGray5))
//        }
//        HStack(alignment: .bottom, spacing: 5){
//            Rectangle()
//                .frame(width: 7, height: 85)
//                .foregroundColor(Color(.blue))
//            Rectangle()
//                .frame(width: 7, height: 70)
//                .foregroundColor(Color(.systemTeal))
//            Rectangle()
//                .frame(width: 7, height: 45)
//                .foregroundColor(Color(.systemPink))
//            Rectangle()
//                .frame(width: 7, height: 80)
//                .foregroundColor(Color(.systemOrange))
//        }
//    }
//    .padding(.bottom, 10)
//    Text("May")
//        .font((Font.custom("DIN Alternate Bold", size: 16)))
//}

//ScrollView(.horizontal) {
//    ForEach(1..<12) { month in
//        VStack(){
//            Spacer()
//            ZStack(alignment: .bottom){
//                HStack(alignment: .bottom, spacing: 5){
//                    Rectangle()
//                        .frame(width: 7, height: 100)
//                        .foregroundColor(Color(.systemGray5))
//                    Rectangle()
//                        .frame(width: 7, height:130)
//                        .foregroundColor(Color(.systemGray5))
//                    Rectangle()
//                        .frame(width: 7, height: 50)
//                        .foregroundColor(Color(.systemGray5))
//                    Rectangle()
//                        .frame(width: 7, height: 70)
//                        .foregroundColor(Color(.systemGray5))
//                }
//                HStack(alignment: .bottom, spacing: 5){
//                    Rectangle()
//                        .frame(width: 7, height: 60)
//                        .foregroundColor(Color(.blue))
//                    Rectangle()
//                        .frame(width: 7, height: 60)
//                        .foregroundColor(Color(.systemTeal))
//                    Rectangle()
//                        .frame(width: 7, height: 30)
//                        .foregroundColor(Color(.systemPink))
//                    Rectangle()
//                        .frame(width: 7, height: 50)
//                        .foregroundColor(Color(.systemOrange))
//                }
//            }
//            .padding(.bottom, 10)
//            Text(months[month]) // ("Mar")
//                .font((Font.custom("DIN Alternate Bold", size: 16)))
//        }
//    }
//}

//                VStack(){
//                    Spacer()
//                    ZStack(alignment: .bottom){
//                        HStack(alignment: .bottom, spacing: 5){
//                            Rectangle()
//                                .frame(width: 7, height: 100)
//                                .foregroundColor(Color(.systemGray5))
//                            Rectangle()
//                                .frame(width: 7, height:130)
//                                .foregroundColor(Color(.systemGray5))
//                            Rectangle()
//                                .frame(width: 7, height: 50)
//                                .foregroundColor(Color(.systemGray5))
//                            Rectangle()
//                                .frame(width: 7, height: 70)
//                                .foregroundColor(Color(.systemGray5))
//                        }
//                        HStack(alignment: .bottom, spacing: 5){
//                            Rectangle()
//                                .frame(width: 7, height: 60)
//                                .foregroundColor(Color(.blue))
//                            Rectangle()
//                                .frame(width: 7, height: 60)
//                                .foregroundColor(Color(.systemTeal))
//                            Rectangle()
//                                .frame(width: 7, height: 30)
//                                .foregroundColor(Color(.systemPink))
//                            Rectangle()
//                                .frame(width: 7, height: 50)
//                                .foregroundColor(Color(.systemOrange))
//                        }
//                    }
//                    .padding(.bottom, 10)
//                    Text("Mar")
//                        .font((Font.custom("DIN Alternate Bold", size: 16)))
//                }
//                VStack(){
//                    Spacer()
//                    ZStack(alignment: .bottom){
//                        HStack(alignment: .bottom, spacing: 5){
//                            Rectangle()
//                                .frame(width: 7, height: 80)
//                                .foregroundColor(Color(.systemGray5))
//                            Rectangle()
//                                .frame(width: 7, height: 100)
//                                .foregroundColor(Color(.systemGray5))
//                            Rectangle()
//                                .frame(width: 7, height: 120)
//                                .foregroundColor(Color(.systemGray5))
//                            Rectangle()
//                                .frame(width: 7, height: 90)
//                                .foregroundColor(Color(.systemGray5))
//                        }
//                        HStack(alignment: .bottom, spacing: 5){
//                            Rectangle()
//                                .frame(width: 7, height: 70)
//                                .foregroundColor(Color(.blue))
//                            Rectangle()
//                                .frame(width: 7, height: 60)
//                                .foregroundColor(Color(.systemTeal))
//                            Rectangle()
//                                .frame(width: 7, height: 110)
//                                .foregroundColor(Color(.systemPink))
//                            Rectangle()
//                                .frame(width: 7, height: 40)
//                                .foregroundColor(Color(.systemOrange))
//                        }
//                    }
//                    .padding(.bottom, 10)
//                    Text("Apr")
//                        .font((Font.custom("DIN Alternate Bold", size: 16)))
//                }
//                VStack(){
//                    Spacer()
//                    ZStack(alignment: .bottom){
//                        HStack(alignment: .bottom, spacing: 5){
//                            Rectangle()
//                                .frame(width: 7, height: 100)
//                                .foregroundColor(Color(.systemGray5))
//                            Rectangle()
//                                .frame(width: 7, height: 120)
//                                .foregroundColor(Color(.systemGray5))
//                            Rectangle()
//                                .frame(width: 7, height: 90)
//                                .foregroundColor(Color(.systemGray5))
//                            Rectangle()
//                                .frame(width: 7, height: 100)
//                                .foregroundColor(Color(.systemGray5))
//                        }
//                        HStack(alignment: .bottom, spacing: 5){
//                            Rectangle()
//                                .frame(width: 7, height: 85)
//                                .foregroundColor(Color(.blue))
//                            Rectangle()
//                                .frame(width: 7, height: 70)
//                                .foregroundColor(Color(.systemTeal))
//                            Rectangle()
//                                .frame(width: 7, height: 45)
//                                .foregroundColor(Color(.systemPink))
//                            Rectangle()
//                                .frame(width: 7, height: 80)
//                                .foregroundColor(Color(.systemOrange))
//                        }
//                    }
//                    .padding(.bottom, 10)
//                    Text("May")
//                        .font((Font.custom("DIN Alternate Bold", size: 16)))
//                }
