import SwiftUI

struct BudgetCardView : View {
    @StateObject var viewModel: BudgetViewModel
    @Binding var editBudgets: Bool
    @State var degrees: Double = 180
    @State var selectedCategory: Int = 0
    @State var showPicker: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .top){
            if !editBudgets {
                ZStack{
                    Card(width: 375, height: 375)
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
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            
            else {
                ZStack(alignment: .top){
                    Card(width: 375, height: 390)
                    VStack(spacing: 10){
                        HStack(){
                            Text("Edit Budgets")
                                .font((Font.custom("DIN Alternate Bold", size: 20)))
                            Spacer()
                            Button(action: { viewModel.update(); self.editBudgets = false;
                                    withAnimation { self.degrees -= 180;} }) {
                                Image(systemName: "checkmark")
                                    .imageScale(.medium)
                                    .foregroundColor(Color(.black))
                            }
                        }
                        .padding(.trailing, 40)
                        .padding(.leading, 50)
                        .padding(.top, 30)
                        VStack(){
                            ForEach(viewModel.budgets.indices) { index in
                                VStack(spacing: 5){
                                    HStack(){
                                        ZStack{
                                            Circle()
                                                .stroke(Color(.white), lineWidth: 3)
                                                .frame(width: 40, height:40)
                                            Image(systemName: viewModel.budgets[index].iconName)
                                                .foregroundColor(viewModel.budgets[index].color)
                                        }
                                        Text("\(viewModel.budgets[index].category)")
                                            .font((Font.custom("DIN Alternate Bold", size: 14)))
                                        Spacer()
                                        TextField("$\(viewModel.budgets[index].limit, specifier: "%.2f")", value: $viewModel.budgets[index].limit, formatter: NumberFormatter())
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .fixedSize()
                                            .multilineTextAlignment(.trailing)
                                    }
                                    Divider()
                                        .padding(.top, 5)
                                        .padding(.bottom, 5)
                                }
                            }
                            Spacer()
                            HStack{
                                Button(action: { viewModel.update(); }) {
                                    Image(systemName: "minus")
                                        .imageScale(.large)
                                        .foregroundColor(Color(.black))
                                }
                                Spacer()
                                Button(action: { viewModel.update(); showPicker = true; }) {
                                    Image(systemName: "plus")
                                        .imageScale(.large)
                                        .foregroundColor(Color(.black))
                                }
                            }
                            .padding(.bottom, 5)
                            Spacer()
                        }
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                        .padding(.top, 30)
                    }
                }
            }
        }
        .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut)
//        .overlay(PickerWheel(showPicker: $showPicker))
    }
    
    
    struct PickerWheel: View {
        @State var selected: Int = 0
        @Binding var showPicker: Bool
        
        var body: some View {
            VStack(spacing: 15){
                HStack{
                    Button(action: { showPicker = false }){
                        Text("Cancel")
                    }
                    Spacer()
                    Button(action: { showPicker = false }){
                        Text("Done")
                    }
                }
                .padding(.leading, 15)
                .padding(.trailing, 15)
                Divider()
                Picker("", selection: $selected){
                    ForEach(UserData.Category.allCases, id: \.self){ category in
                        Text(category.name)
                    }
                }
            }
            .padding(.top, 15)
            .background(Color(.white))
        }
    }
}
