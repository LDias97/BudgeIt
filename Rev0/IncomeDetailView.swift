//
//  IncomeDetailView.swift
//  Rev0
//
//  Created by Luann Dias on 3/6/21.
//

import SwiftUI


// The values should be "Payment/Salary" and "Other Income" instead of entertainment, food, etc.
// The values of the pie chart should change and rotate after clicking each chevron button and the list of options to see
struct IncomeDetailView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter

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
                    Text("Income").font(.title3).bold()
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

struct IncomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeDetailView()
    }
}

