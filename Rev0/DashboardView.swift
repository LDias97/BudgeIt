//import CorePlot
//import Charts
import SwiftUI

struct DashboardView: View {
    
    // Hardcoding values for now
    // Will change values once we get real transactions
    @State private var totalNetworth = 12345
    @State private var totalSpent = 1200
    let categories = ["Home & Utility", "Transportation", "Restaurant & Dining", "Shopping & Entertainment", "Cash, Checks, Misc."]
    // let button1 = UIButton(type: <#T##UIButton.ButtonType#>)
    

    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    Text("Total Networth")
                        .underline()
                    Text("\(totalNetworth)")
                    
                    Divider()
                    
                    HStack {
                        Text("Spending")
                            .font(.title)
                            .padding(10)
                        Spacer()
                        Text("$\(totalSpent)")
                            .padding(10)
                        }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Button(action:{ print("Clicked cat.0")}) {
                            Text("\(categories[0])")
                                .font(.title)
                                .id("cat0")
                        }
                        Button(action:{ print("Clicked cat.1")}) {
                            Text("\(categories[1])")
                                .font(.title)
                        }
                        Button(action:{ print("Clicked cat.2")}) {
                            Text("\(categories[2])")
                                .font(.title)
                        }
                        Button(action:{ print("Clicked cat.3")}) {
                            Text("\(categories[3])")
                                .font(.title)
                        }
                        Button(action:{ print("Clicked cat.4")}) {
                            Text("\(categories[4])")
                                .font(.title)
                        }
                        }
                }
                
            }
            .navigationBarTitle("BudgeIt", displayMode: .inline)
        }
    }
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
