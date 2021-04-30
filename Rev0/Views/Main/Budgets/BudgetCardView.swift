import SwiftUI

struct BudgetCardView : View {
    @StateObject var viewModel: BudgetViewModel
    @EnvironmentObject var userData: UserData
    @State private var editBudgets: Bool = false
    @State var degrees: Double = 180
    @State private var addClicked: Bool = false
    @State private var deleteClicked: Bool = false
    @State private var minusClicked: Bool = false
    @State private var plusToX: Bool = false
    @State private var showPicker: Bool = false
    @Binding var showingAlert: Bool
    
    var body: some View {
        
        ZStack(alignment: .top){
            if !editBudgets {
                ZStack{
                    VStack(spacing: 15){
                        HStack(){
                            Text("Budgets")
                                .font((Font.custom("DIN Alternate Bold", size: 20)))
                            Spacer()
                            Button(action: { self.editBudgets = true;
                                    withAnimation { self.degrees += 180;} }) {
                                Image(systemName: "pencil")
                                    .imageScale(.medium)
                                    .foregroundColor(Color(.black))
                            }
                        }
                        .padding(.top, 20)
                        .padding(.leading, 50)
                        .padding(.trailing, 40)
                        VStack(){
                            if(viewModel.budgets.isEmpty){
                                Button(action: { self.editBudgets = true;
                                        withAnimation { self.degrees += 180;} }){
                                    Text("Add a Budget")
                                }
                                .padding(.bottom)
                                
                            }
                            ForEach(viewModel.budgets) { budget in
                                VStack(){
                                    HStack{
                                        ProgressCircle(percentage: budget.percentage, color: budget.color, iconName: budget.iconName)
                                        VStack(spacing: 5){
                                            HStack(){
                                                Text("\(budget.category)")
                                                    
                                                    .font((Font.custom("DIN Alternate Bold", size: 14)))
                                                    .bold()
                                                Spacer()
                                            }
                                            HStack(){
                                                Text("$\(budget.limit - budget.spent, specifier: "%.2f") left")
                                                    .font((Font.custom("DIN Alternate Bold", size: 12)))
                                                    .foregroundColor(.gray)
                                                Spacer()}
                                        }
                                        Spacer()
                                        VStack(spacing: 5){
                                            HStack(){
                                                Spacer()
                                                Text("$\(budget.limit, specifier: "%.2f")")
                                                    .font((Font.custom("DIN Alternate Bold", size: 14)))
                                                    .foregroundColor(Color(.blue))
                                                    .bold()
                                            }
                                            HStack(){
                                                Spacer()
                                                Text("$\(budget.spent, specifier: "%.2f") of $\(budget.limit, specifier: "%.2f")")
                                                    .font((Font.custom("DIN Alternate Bold", size: 12)))
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                    Divider()
                                        .padding(.top, 5)
                                        .padding(.bottom, 5)
                                }
                            }
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                        }
                        .padding(.top, 20)
                        Spacer()
                    }
                }
                .background(Card())
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            
            else {
                ZStack{
                    VStack(spacing: 10){
                        HStack(){
                            Text("Edit Budgets")
                                .font((Font.custom("DIN Alternate Bold", size: 20)))
                            Spacer()
                            Button(action: { viewModel.update(); self.editBudgets = false; self.addClicked = false; self.deleteClicked = false;
                                    withAnimation { self.degrees -= 180;} }) {
                                Image(systemName: "checkmark")
                                    .imageScale(.medium)
                                    .foregroundColor(Color(.black))
                            }
                            
                        }
                        .padding(.top, 20)
                        .padding(.leading, 50)
                        .padding(.trailing, 40)
                        VStack(){
                            if(viewModel.budgets.count != 0){
                                ForEach(viewModel.budgets) { budget in
                                    VStack{
                                        Spacer()
                                        HStack(){
                                            if(deleteClicked) {
                                                Button(action: {
                                                    minusClicked = true;
                                                    viewModel.remove(budget: budget);
                                                } ) {
                                                    Image(systemName: "minus")
                                                        .imageScale(.large)
                                                        .foregroundColor(Color(.white))
                                                        .background(Circle().foregroundColor(.red).scaledToFill())
                                                }
                                            }
                                            ZStack{
                                                Circle()
                                                    .stroke(Color(.white), lineWidth: 3)
                                                    .frame(width: 40, height:40)
                                                Image(systemName: budget.iconName)
                                                    .foregroundColor(budget.color)
                                            }
                                            Text("\(budget.category)")
                                                .font((Font.custom("DIN Alternate Bold", size: 14)))
                                            Spacer()
                                            TextField("$\(budget.limit, specifier: "%.2f")",
                                                      value: Binding(
                                                        get: { budget.limit },
                                                        set: { self.viewModel.budgets[self.viewModel.budgets.firstIndex(of: budget)!].limit = $0 }),
                                                      formatter: NumberFormatter())
                                                .fixedSize()
                                                .multilineTextAlignment(.trailing)
                                                .alert(isPresented: $showingAlert) {
                                                    Alert(title: Text("Budget Exceeded"), message: Text("\(self.viewModel.budgets[self.viewModel.budgets.firstIndex(of: budget)!].category)" + " budget exceeded"))
                                                }
                                                .foregroundColor(Color(.systemGray2))
                                        }
                                        Divider()
                                    }
                                }
                            }
                            else{
                                NewRow(viewModel: viewModel, showPicker: $showPicker, addClicked: $addClicked)
                            }
                            
                            Spacer()
                            if addClicked {
                                NewRow(viewModel: viewModel, showPicker: $showPicker, addClicked: $addClicked)
                            }
                            Spacer()
                            HStack{
                                ZStack{
                                    //                                    Button(action: { addClicked = false; plusToX = !plusToX; cancelDegrees = 0; }){
                                    //                                        Text("Done")
                                    //                                            .foregroundColor(plusToX ? Color(.blue) : Color(.clear))
                                    //                                    }
                                    //                                    .disabled(!plusToX)
                                    Button(action: { deleteClicked = !deleteClicked;  }) {
                                        if(deleteClicked){
                                            Text("Done")
                                        }
                                        else{
                                            Image(systemName: "minus")
                                                .imageScale(.large)
                                                .foregroundColor(addClicked ? Color(.clear) : Color(.black))
                                                .background(Rectangle().foregroundColor(.clear).scaledToFill())
                                        }
                                    }
                                    .disabled(addClicked)
                                    
                                }
                                Spacer()
                                Button(action: { addClicked = !addClicked; deleteClicked = false;}) {
                                    Image(systemName: "plus")
                                        .imageScale(.large)
                                        .foregroundColor(Color(.black))
                                        .background(Rectangle().foregroundColor(.clear).scaledToFill())
                                        .rotationEffect(Angle.init(degrees: addClicked ? 45 : 0))
                                }
                            }
                            .padding(.bottom, 5)
                            Spacer()
                        }
                        .padding(.top, 20)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                    }
                }
                .background(Card())
            }
        }
        .onTapGesture { if (!minusClicked){ deleteClicked = false; } else { minusClicked = false }}
        .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut)
    }
}

struct  NewRow: View {
    
    @StateObject var viewModel: BudgetViewModel
    @State private var selected: Int = 1
    @Binding var showPicker: Bool
    @Binding var addClicked: Bool
    
    var body: some View {
        VStack{
            Spacer()
            HStack(){
                if(!showPicker){
                    HStack(){
                        Button(action: { showPicker = true; } ){
                            ZStack{
                                Circle()
                                    .stroke(Color(.white), lineWidth: 3)
                                    .frame(width: 40, height:40)
                                Image(systemName: "pencil")
                                    .foregroundColor(blue)
                            }
                            Text("Select Category")
                                .font((Font.custom("DIN Alternate Bold", size: 14)))
                                .foregroundColor(blue)
                        }
                        Spacer()
                    }
                }
                
                else{
                    VStack{
                        HStack{
                            Spacer()
                            Button(action: { viewModel.addBudget(category: UserData.Category(rawValue: selected)!); self.showPicker = false; self.addClicked = !addClicked; } ) {
                                Text("Add")
                            }
                        }
                        .padding(.bottom)
                        Picker("", selection: $selected){
                            ForEach(UserData.Category.allCases, id: \.self){ category in
                                Text(category.name).tag(category.rawValue)
                            }
                        }
                        .frame(width: 150, height: 175)
                    }
                }
            }
            Divider()
        }
        .padding(.bottom, 5)
    }
}

struct DefaultRow: View {
    
    var body: some View {
        VStack{
            Spacer()
            HStack(){
                ZStack{
                    Circle()
                        .stroke(Color(.white), lineWidth: 3)
                        .frame(width: 40, height:40)
                    Image(systemName: "dollarsign.circle")
                        .foregroundColor(Color(.systemGray2))
                }
                Rectangle()
                    .frame(width: 150, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(.systemGray2))
                Spacer()
                Rectangle()
                    .frame(width: 80, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(.systemGray2))
                
            }
            Divider()
        }
    }
}

struct DefaultBudgetCard : View {
    
    
    var body: some View {
        
        VStack(){
            ForEach(0..<4) { num in
                DefaultRow()
            }
            
        }
    }
    
}
