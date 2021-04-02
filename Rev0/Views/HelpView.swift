import SwiftUI

struct HelpView: View {
    
    @State var isEnabled1: Bool = false
    @State var isEnabled2: Bool = false
    @State var isEnabled3: Bool = false
    
    var body: some View {
        
        ZStack(alignment:.top){
            Rectangle()
                .fill(Color(.systemGray6))
            VStack(){
                Spacer()
                HStack{
                    Toggle("Option1", isOn: $isEnabled1)
                }
                HStack{
                    Toggle("Option2", isOn: $isEnabled1)
                }
                HStack{
                    Toggle("Option3", isOn: $isEnabled1)
                }
                Spacer()
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}

